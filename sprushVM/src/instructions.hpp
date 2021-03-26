//
// Created by Archer on 3/25/2021.
//

#ifndef SPRUSHVM_INSTRUCTIONS_HPP
#define SPRUSHVM_INSTRUCTIONS_HPP

#include <llvm/IR/Module.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/NoFolder.h>
#include <llvm/IR/InlineAsm.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/ExecutionEngine/ExecutionEngine.h>
#include <llvm/ExecutionEngine/GenericValue.h>
#include <llvm/ExecutionEngine/Interpreter.h>

#include <utility>

#include "utils.hpp"

using namespace llvm;

namespace arch
{
    struct instruction_info
    {
        std::vector<uint8_t> instruction;
        size_t address;
        bool terminator;

        instruction_info( std::vector<uint8_t> instr, size_t addr ) :
                instruction( std::move( instr ) ),
                address( addr ),
                terminator( false )
        {}

        template<size_t N>
        auto byte()
        {
            assert (N < instruction.size() );
            return instruction[ N ];
        }

        template<size_t N>
        auto dword()
        {
            assert( N + 4 <= instruction.size() );
            uint32_t out =  ( instruction[ N + 3 ] << 0 )  |
                            ( instruction[ N + 2 ] << 8 )  |
                            ( instruction[ N + 1 ] << 16 ) |
                            ( instruction[ N + 0 ] << 24 );
            return out;
        }

        auto to_string()
        {
            assert( instruction.size() > 0 );
            return utils::fmt( "0x%x\t0x%x", address, instruction[ 0 ] );
        }
    };

    struct context_info
    {
        Module& program;
        IRBuilder<NoFolder>& builder;
        std::vector<size_t>& todo;
        std::unordered_map<size_t, Instruction*> instructions{};
        auto ctx() { return std::tie( program, builder ); }
    };

    using instruction_t = void( * )( instruction_info&, context_info& );

    // Simple hack that allows us to split basic blocks by address
    Instruction* make_nop( IRBuilder<NoFolder>& builder )
    {
        builder.CreateAdd( builder.getInt32( 1337 ), builder.getInt32( 1337 ) );
        return &builder.GetInsertBlock()->back();
    }

    struct instruction
    {
        static void mov_reg_reg( instruction_info& info, context_info& context )
        {
            auto [program, builder] =context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto src = info.byte<1>();
            auto dst = info.byte<2>();

            auto src_r = program.getNamedGlobal( utils::fmt( "R%x", src ) );
            auto dst_r = program.getNamedGlobal( utils::fmt( "R%x", dst ) );

            builder.CreateStore( builder.CreateLoad( src_r ), dst_r );
        }

        static void mov_reg_imm( instruction_info& info, context_info& context )
        {
            auto [program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto dst = info.byte<1>();
            auto imm = info.dword<2>();

            auto dst_r = program.getNamedGlobal( utils::fmt( "R%x", dst ) );

            builder.CreateStore( builder.getInt32( imm ), dst_r );
        }

        static void mov_reg_mem( instruction_info& info, context_info& context )
        {
            auto [program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto dst = info.byte<1>();
            auto src = info.byte<2>();

            auto src_r = program.getNamedGlobal( utils::fmt( "R%x", src ) );
            auto dst_r = program.getNamedGlobal( utils::fmt( "R%x", dst ) );
            auto main  = program.getFunction( "main" );
            auto memory= program.getNamedGlobal( "memory" );
            auto data  = program.getNamedGlobal( "data" );

            auto dst_v = builder.CreateLoad( dst_r );
            auto cond  = builder.CreateICmpULE( dst_v, builder.getInt32( 0xffff ) );

            // The way our disassembler works, every instruction is lifted only once.
            // So there is no need to check if basic block exists
            auto dst_f = BasicBlock::Create( program.getContext(), utils::fmt( "0x%x_f", info.address ), main );
            auto dst_t = BasicBlock::Create( program.getContext(), utils::fmt( "0x%x_t", info.address ), main );
            auto next  = BasicBlock::Create( program.getContext(), utils::fmt( "0x%x", info.address + 3 ), main );

            // Create conditional jmp
            builder.CreateCondBr( cond, dst_t, dst_f );

            // Fill False block
            builder.SetInsertPoint( dst_f );
            auto offset  = builder.CreateSub( dst_v, builder.getInt32( 0x10000 ) );
            auto dst_ar  = builder.CreateInBoundsGEP( memory, { ConstantInt::get( builder.getInt32Ty() , APInt( 32, 0 ) ), offset } );
            auto dst_ptr = builder.CreateIntCast( dst_ar, builder.getInt8Ty()->getPointerTo(), false );
            auto value   = builder.CreateIntCast( builder.CreateLoad( dst_ptr ), builder.getInt32Ty(), false );
            builder.CreateStore( value, src_r );
            builder.CreateBr( next );

            // Fill True block
            builder.SetInsertPoint( dst_t );
            offset  = dst_v;
            dst_ar  = builder.CreateInBoundsGEP( data, { ConstantInt::get( builder.getInt32Ty() , APInt( 32, 0 ) ), offset } );
            dst_ptr = builder.CreateIntCast( dst_ar, builder.getInt8Ty()->getPointerTo(), false );
            value   = builder.CreateIntCast( builder.CreateLoad( dst_ptr ), builder.getInt32Ty(), false );
            builder.CreateStore( value, src_r );
            builder.CreateBr( next );

            builder.SetInsertPoint( next );
        }

        static void mov_mem_reg( instruction_info& info, context_info& context )
        {
            auto [program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto dst = info.byte<1>();
            auto src = info.byte<2>();

            auto data   = program.getNamedGlobal( "memory" );
            auto src_r  = program.getNamedGlobal( utils::fmt( "R%x", src ) );
            auto dst_r  = program.getNamedGlobal( utils::fmt( "R%x", dst ) );

            auto offset = builder.CreateSub( builder.CreateLoad( dst_r ), builder.getInt32( 0x10000 ) );
            auto src_v  = builder.CreateIntCast( builder.CreateLoad( src_r ), builder.getInt8Ty(), false );

            auto dst_ar  = builder.CreateInBoundsGEP( data, { ConstantInt::get( builder.getInt32Ty() , APInt( 32, 0 ) ), offset } );
            auto dst_ptr = builder.CreateIntCast( dst_ar, builder.getInt8Ty()->getPointerTo(), false );

            builder.CreateStore( src_v, dst_ptr );
        }

        static void write( instruction_info& info, context_info& context )
        {
            auto [program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto dst = info.byte<1>();
            auto src = info.byte<2>();

            auto write  = program.getFunction( "write" );
            auto data   = program.getNamedGlobal( "data" );
            auto src_r  = program.getNamedGlobal( utils::fmt( "R%x", src ) );
            auto dst_r  = program.getNamedGlobal( utils::fmt( "R%x", dst ) );

            auto offset = builder.CreateLoad( dst_r );
            auto size   = builder.CreateLoad( src_r );
            auto dst_ar  = builder.CreateInBoundsGEP( data, { ConstantInt::get( builder.getInt32Ty() , APInt( 32, 0 ) ), offset } );
            auto dst_ptr = builder.CreateIntCast( dst_ar, builder.getInt8Ty()->getPointerTo(), false );

            builder.CreateCall( write, { builder.getInt32(1), dst_ptr, size });
        }

        static void read( instruction_info& info, context_info& context )
        {
            auto [program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto dst = info.byte<1>();
            auto src = info.byte<2>();

            auto read   = program.getFunction( "read" );
            auto data   = program.getNamedGlobal( "memory" );
            auto src_r  = program.getNamedGlobal( utils::fmt( "R%x", src ) );
            auto dst_r  = program.getNamedGlobal( utils::fmt( "R%x", dst ) );

            auto offset = builder.CreateSub( builder.CreateLoad( dst_r ), builder.getInt32( 0x10000 ) );
            auto size   = builder.CreateLoad( src_r );
            auto dst_ar  = builder.CreateInBoundsGEP( data, { ConstantInt::get( builder.getInt32Ty() , APInt( 32, 0 ) ), offset } );
            auto dst_ptr = builder.CreateIntCast( dst_ar, builder.getInt8Ty()->getPointerTo(), false );

            builder.CreateCall( read, { builder.getInt32( 0 ), dst_ptr, size });
        }

        static void xor_reg_reg( instruction_info& info, context_info& context )
        {
            auto [program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto dst = info.byte<1>();
            auto src = info.byte<2>();

            auto dst_r = program.getNamedGlobal( utils::fmt( "R%x", dst ) );
            auto src_r = program.getNamedGlobal( utils::fmt( "R%x", src ) );

            auto src_v = builder.CreateLoad( src_r );
            auto dst_v = builder.CreateLoad( dst_r );
            auto value = builder.CreateXor( src_v, dst_v );

            builder.CreateStore( value, dst_r );
        }

        static void xor_reg_imm( instruction_info& info, context_info& context )
        {
            auto [program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto dst = info.byte<1>();
            auto src = info.dword<2>();

            auto dst_r = program.getNamedGlobal( utils::fmt("R%x", dst ) );

            auto src_v = builder.getInt32( src );
            auto dst_v = builder.CreateLoad( dst_r );
            auto value = builder.CreateXor( src_v, dst_v );

            builder.CreateStore( value, dst_r );
        }

        static void add( instruction_info& info, context_info& context )
        {
            auto [program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto dst = info.byte<1>();
            auto src = info.byte<2>();

            auto dst_r = program.getNamedGlobal( utils::fmt("R%x", dst ) );
            auto src_r = program.getNamedGlobal( utils::fmt("R%x", src ) );

            auto src_v = builder.CreateLoad( src_r );
            auto dst_v = builder.CreateLoad( dst_r );
            auto value = builder.CreateAdd( src_v, dst_v );

            builder.CreateStore( value, dst_r );
        }

        static void inc( instruction_info& info, context_info& context )
        {
            auto[program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto dst = info.byte<1>();

            auto dst_r = program.getNamedGlobal( utils::fmt("R%x", dst ) );

            auto dst_v = builder.CreateLoad( dst_r );
            auto value = builder.CreateAdd( builder.getInt32( 1 ), dst_v );

            builder.CreateStore( value, dst_r );
        }

        static void cmp_reg_reg( instruction_info& info, context_info& context )
        {
            auto[program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto reg1 = info.byte<1>();
            auto reg2 = info.byte<2>();

            auto reg1_r = program.getNamedGlobal( utils::fmt("R%x", reg1 ) );
            auto reg2_r = program.getNamedGlobal( utils::fmt("R%x", reg2 ) );
            auto zf_r   = program.getNamedGlobal( "ZF" );
            auto of_r   = program.getNamedGlobal( "OF" );

            auto reg1_v = builder.CreateLoad( reg1_r );
            auto reg2_v = builder.CreateLoad( reg2_r );

            builder.CreateStore( builder.CreateICmpEQ(  reg1_v, reg2_v ), zf_r );
            builder.CreateStore( builder.CreateICmpUGE( reg1_v, reg2_v ), of_r );
        }

        static void cmp_reg_imm( instruction_info& info, context_info& context )
        {
            auto[program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto reg = info.byte<1>();
            auto imm = info.dword<2>();

            auto reg_r = program.getNamedGlobal( utils::fmt("R%x", reg ) );
            auto zf_r   = program.getNamedGlobal( "ZF" );
            auto of_r   = program.getNamedGlobal( "OF" );

            auto reg_v = builder.CreateLoad( reg_r );
            auto imm_v  = builder.getInt32( imm );

            builder.CreateStore( builder.CreateICmpEQ(  reg_v, imm_v ), zf_r );
            builder.CreateStore( builder.CreateICmpUGE( reg_v, imm_v ), of_r );
        }

        static void jg( instruction_info& info, context_info& context )
        {
            auto[program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto dst = info.dword<1>() - 0x1000;

            auto main = program.getFunction( "main" );
            auto of_r = program.getNamedGlobal( "OF" );
            auto cond = builder.CreateLoad( of_r );

            auto dst_t = utils::find_block( main->getBasicBlockList(), utils::fmt( "0x%x", info.address + 5 ) );
            auto dst_f = utils::find_block( main->getBasicBlockList(), utils::fmt( "0x%x", dst ) );

            if ( !dst_t )
            {
                dst_t = BasicBlock::Create( program.getContext(), utils::fmt( "0x%x", info.address + 5 ), main );
                context.todo.push_back( info.address + 5 );
            }
            else if ( context.instructions.find( info.address + 5 ) != context.instructions.end() )
            {
                // Split basic block
                auto instr = context.instructions[ info.address + 5 ];
                instr->getParent()->splitBasicBlock( instr, utils::fmt( "0x%0x", info.address + 5 ) );
            }

            if ( !dst_f )
            {
                dst_f = BasicBlock::Create( program.getContext(), utils::fmt( "0x%x", dst ), main );
                context.todo.push_back( dst );
            }
            else if ( context.instructions.find( dst ) != context.instructions.end() )
            {
                // Split basic block
                auto instr = context.instructions[ dst ];
                instr->getParent()->splitBasicBlock( instr, utils::fmt( "0x%0x", dst ) );
            }

            builder.CreateCondBr( cond, dst_t, dst_f );
            info.terminator = true;
        }

        static void jne( instruction_info& info, context_info& context )
        {
            auto[program, builder] = context.ctx();
            context.instructions.insert( { info.address, make_nop( builder ) } );
            auto dst = info.dword<1>() - 0x1000;

            auto main = program.getFunction( "main" );
            auto zf_r = program.getNamedGlobal( "ZF" );
            auto cond = builder.CreateLoad( zf_r );

            auto dst_t = utils::find_block( main->getBasicBlockList(), utils::fmt( "0x%x", info.address + 5 ) );
            auto dst_f = utils::find_block( main->getBasicBlockList(), utils::fmt( "0x%x", dst ) );

            if ( !dst_t )
            {
                dst_t = BasicBlock::Create( program.getContext(), utils::fmt( "0x%x", info.address + 5 ), main );
                context.todo.push_back( info.address + 5 );
            }
            else if ( context.instructions.find( info.address + 5 ) != context.instructions.end() )
            {
                // Split basic block
                auto instr = context.instructions[ info.address + 5 ];
                instr->getParent()->splitBasicBlock( instr, utils::fmt( "0x%0x", info.address + 5 ) );
            }

            if ( !dst_f )
            {
                dst_f = BasicBlock::Create( program.getContext(), utils::fmt( "0x%x", dst ), main );
                context.todo.push_back( dst );
            }
            else if ( context.instructions.find( dst ) != context.instructions.end() )
            {
                // Split basic block
                auto instr = context.instructions[ dst ];
                instr->getParent()->splitBasicBlock( instr, utils::fmt( "0x%0x", dst ) );
            }

            builder.CreateCondBr( cond, dst_t, dst_f );
            info.terminator = true;
        }

        static void ret( instruction_info& info, context_info& context )
        {
            auto [program, builder] = context.ctx();
            builder.CreateRet( nullptr );
            info.terminator = true;
        }
    };
}

#endif //SPRUSHVM_INSTRUCTIONS_HPP
