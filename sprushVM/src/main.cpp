#include <iostream>
#include <filesystem>

#include <llvm/IR/Module.h>
#include <llvm/IR/PassManager.h>
#include <llvm/IR/Verifier.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/NoFolder.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Linker/IRMover.h>
#include <llvm/Support/SourceMgr.h>
#include "llvm/ExecutionEngine/SectionMemoryManager.h"

#include "utils.hpp"
#include "instructions.hpp"

#include <unistd.h>

using namespace llvm;

// map of opcode number [lifter_function, instruction size]
static const std::unordered_map<size_t, std::pair<arch::instruction_t, size_t>> INSTRUCTIONS =
        {
                { 0x00, { arch::instruction::mov_reg_reg, 3 } },
                { 0x01, { arch::instruction::mov_reg_imm, 6 } },
                { 0x02, { arch::instruction::mov_reg_mem, 3 } },
                { 0x03, { arch::instruction::mov_mem_reg, 3 } },
                { 0x26, { arch::instruction::write, 3 } },
                { 0x27, { arch::instruction::read, 3 } },
                { 0x06, { arch::instruction::xor_reg_reg, 3 } },
                { 0x07, { arch::instruction::xor_reg_imm, 6 } },
                { 0x2e, { arch::instruction::add, 3 } },
                { 0x04, { arch::instruction::inc, 2 } },
                { 0x2c, { arch::instruction::cmp_reg_reg, 3 } },
                { 0x2d, { arch::instruction::cmp_reg_imm, 6 } },
                { 0x11, { arch::instruction::jg, 5 } },
                { 0x0d, { arch::instruction::jne, 5 } },
                { 0xff, { arch::instruction::ret, 1 } },
        };

void handle_instructions( const std::vector<uint8_t>& bytecode, Module& program, IRBuilder<NoFolder>& builder, size_t pc = 0 )
{
    // Instruction placeholder
    std::vector<uint8_t> instruction;
    // Basic blocks to disassemble
    std::vector<size_t> todo{ pc };
    // Basic blocks already disassembled
    std::vector<size_t> done;
    // VM Context
    arch::context_info context{ program, builder, todo };

    while ( !todo.empty() )
    {
        pc = todo.back();
        todo.pop_back();
        if ( std::find( done.begin(), done.end(), pc ) != done.end() )
            continue;

        done.push_back( pc );

        auto main  = program.getFunction( "main" );
        auto block = utils::find_block( main->getBasicBlockList(), utils::fmt( "0x%x", pc ) );
        assert( block != nullptr );

        builder.SetInsertPoint( block );

        while ( true )
        {
            assert( pc < bytecode.size() );

            // find matching instruction
            auto match = INSTRUCTIONS.find( bytecode[ pc ] );
            if ( match == INSTRUCTIONS.end() )
            {
                printf( "Unknown instruction at %zu op: %x", pc, bytecode[ pc ] );
                break;
            }

            auto [ handler, instr_size ] = match->second;

            // copy instruction bytes
            instruction.clear();
            instruction.resize( instr_size );
            std::copy( bytecode.begin() + pc, bytecode.begin() + pc + instr_size + 1, instruction.begin() );
            arch::instruction_info info( instruction, pc );

            // lift
            handler( info, context );
            pc += instr_size;

            // Found end block, break
            if ( info.terminator )
                break;
        }
    }
}

void add_externals( Module& program, IRBuilder<NoFolder>& builder )
{
    // Add sys_read
    ArrayRef<Type*> args = { builder.getInt32Ty(), builder.getInt8Ty()->getPointerTo(), builder.getInt32Ty() };
    auto type = FunctionType::get( builder.getInt32Ty(), args, false );
    program.getOrInsertFunction( "read", type );
    // Add sys_write
    args = { builder.getInt32Ty(), builder.getInt8Ty()->getPointerTo(), builder.getInt32Ty() };
    type = FunctionType::get( builder.getInt32Ty(), args, false );
    program.getOrInsertFunction( "write", type );
}

int main( int argc, char** argv )
{
    if ( argc != 2 )
    {
        std::cout << "Usage: ./" <<argv[ 0 ] <<" bytecode.bin" << std::endl;
        return 0;
    }

    auto filename = argv[ 1 ];

    std::filesystem::path path{ filename };
    auto raw = utils::read_file( path );
    auto name = path.filename().string();

    // split raw contents
    auto data = std::vector<uint8_t>( raw.begin(), raw.begin() + 0x1000 );
    auto bytecode = std::vector<uint8_t>( raw.begin() + 0x1000, raw.end() );

    // Initialize llvm context
    LLVMContext context;
    IRBuilder<NoFolder> builder( context );
    Module program( name, context );

    // Create int main() function
    auto type = FunctionType::get( builder.getVoidTy(), false );
    auto func = Function::Create( type, Function::ExternalLinkage, "main", program );

    // Create initial empty basic block
    auto entry = BasicBlock::Create( context, utils::fmt( "0x%x", 0 ), func );
    builder.SetInsertPoint( entry );

    // Add external functions
    add_externals( program, builder );

    // ZF conditional flag
    utils::create_global( program, "ZF", builder.getInt1Ty() );
    // OF conditional flag
    utils::create_global( program, "OF", builder.getInt1Ty() );
    // Set up registers R0-R4
    for (int i = 0; i < 4; i++)
    {
        utils::create_global( program, utils::fmt( "R%x", i ), builder.getInt32Ty() );
    }

    // Set up data
    utils::create_global( program, "data", ArrayType::get( builder.getInt8Ty(), 0x1000 ), data );
    utils::create_global( program, "memory", ArrayType::get( builder.getInt8Ty(), 0x10000 ) );

    // Lift instructions
    handle_instructions( bytecode, program, builder );

    printf( "\n==== Verification ====\n" );
    printf( "Module: %d\n", !verifyModule( program, &outs() ) );
    printf( "Main: %d\n", !verifyFunction( *func, &outs() ) );

    utils::dump_to_file( program, name );
    return 0;
}
