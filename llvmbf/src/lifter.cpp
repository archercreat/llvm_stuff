#include "lifter.hpp"
#include "passes/peepholepass.hpp"
#include <fstream>

#include <llvm-c/Transforms/PassManagerBuilder.h>
#include <llvm/ADT/SmallVector.h>
#include <llvm/ADT/Triple.h>
#include <llvm/Analysis/BasicAliasAnalysis.h>
#include <llvm/Analysis/CFLAndersAliasAnalysis.h>
#include <llvm/Analysis/CFLSteensAliasAnalysis.h>
#include <llvm/Analysis/ScalarEvolutionAliasAnalysis.h>
#include <llvm/Analysis/GlobalsModRef.h>
#include <llvm/Analysis/InlineCost.h>
#include <llvm/Analysis/Passes.h>
#include <llvm/Analysis/ScopedNoAliasAA.h>
#include <llvm/Analysis/TargetLibraryInfo.h>
#include <llvm/Analysis/TypeBasedAliasAnalysis.h>
#include <llvm/IR/DataLayout.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/IR/Verifier.h>
#include <llvm/Support/CommandLine.h>
#include <llvm/Support/ManagedStatic.h>
#include <llvm/Transforms/AggressiveInstCombine/AggressiveInstCombine.h>
#include <llvm/Transforms/IPO.h>
#include <llvm/Transforms/IPO/ForceFunctionAttrs.h>
#include <llvm/Transforms/IPO/FunctionAttrs.h>
#include <llvm/Transforms/IPO/InferFunctionAttrs.h>
#include <llvm/Transforms/IPO/PassManagerBuilder.h>
#include <llvm/Transforms/InstCombine/InstCombine.h>
#include <llvm/Transforms/Instrumentation.h>
#include <llvm/Transforms/Scalar.h>
#include <llvm/Transforms/Scalar/GVN.h>
#include <llvm/Transforms/Scalar/InstSimplifyPass.h>
#include <llvm/Transforms/Scalar/SimpleLoopUnswitch.h>
#include <llvm/Transforms/Utils.h>
#include <llvm/Transforms/Utils/Cloning.h>
#include <llvm/Transforms/Vectorize.h>

#include <llvm/Transforms/IPO/AlwaysInliner.h>

lifter::lifter(std::shared_ptr<llvm::Module> module)
: module(module)
{
    auto stub = module->getFunction("stub");
    // Create hooked_stub function
    f_stub = llvm::Function::Create(stub->getFunctionType(), llvm::Function::ExternalLinkage, "hooked_stub", module.get());
    // Add alwaysinline attribute which enables important optimizations
    f_stub->addFnAttr(llvm::Attribute::AlwaysInline);
    cur_block = llvm::BasicBlock::Create(module->getContext(), "", f_stub);
    data = stub->getArg(0);
    // Create local pointer and initialize it with 0
    ptr = new llvm::AllocaInst(llvm::Type::getInt64Ty(module->getContext()), 0, "ptr", cur_block);
    new llvm::StoreInst(llvm::ConstantInt::get(llvm::Type::getInt64Ty(module->getContext()), 0), ptr, cur_block);
    // ptr = stub->getArg(1);
}

void lifter::lift_instruction(char op)
{
    switch (op)
    {
    case '>': emit_add_ptr(1);   break;
    case '<': emit_add_ptr(-1);  break;
    case '+': emit_add(1);       break;
    case '-': emit_add(-1);      break;
    case '.': emit_putc();       break;
    case ',': emit_getc();       break;
    case '[': emit_loop_start(); break;
    case ']': emit_loop_end();   break;
    default:                     break;
    }
}

void lifter::dump(std::string& path)
{
    std::string ir;
    llvm::raw_string_ostream stream(ir);
    module->print(stream, nullptr);

    std::ofstream output(path);
    output << ir;
    output.close();
}

void lifter::terminate()
{
    llvm::ReturnInst::Create(module->getContext(), cur_block);

    // Replace call to stub function with hooked_stub function
    for (auto& ins : module->getFunction("lifted")->getEntryBlock())
    {
        if (auto* call = llvm::dyn_cast<llvm::CallInst>(&ins))
        {
            if (call->getCalledFunction() == module->getFunction("stub"))
            {
                call->setCalledFunction(f_stub);
                break;
            }
        }
    }

    // Create actual main function and call `lifted`
    auto f_main = llvm::Function::Create(
        llvm::FunctionType::get(llvm::Type::getVoidTy(module->getContext()), false),
        llvm::Function::ExternalLinkage, "main", module.get());
    auto entry = llvm::BasicBlock::Create(module->getContext(), "", f_main);

    llvm::CallInst::Create(module->getFunction("lifted"), {}, "", entry);
    llvm::ReturnInst::Create(module->getContext(), entry);
}

void lifter::optimize()
{
    llvm::legacy::PassManager mpm;
    llvm::legacy::FunctionPassManager fpm(module.get());

    mpm.add(llvm::createAlwaysInlinerLegacyPass(true));
    fpm.add(llvm::createTypeBasedAAWrapperPass());
    fpm.add(llvm::createScopedNoAliasAAWrapperPass());
    fpm.add(llvm::createLowerExpectIntrinsicPass());
    fpm.add(llvm::createCFGSimplificationPass());
    fpm.add(llvm::createSROAPass());
    fpm.add(llvm::createEarlyCSEPass());
    fpm.add(llvm::createInstructionCombiningPass());
    fpm.add(llvm::createCFGSimplificationPass());
    fpm.add(llvm::createGVNHoistPass());
    fpm.add(llvm::createGVNSinkPass());
    fpm.add(llvm::createCFGSimplificationPass());
    fpm.add(llvm::createJumpThreadingPass());
    fpm.add(llvm::createLoopUnrollPass());
    
    fpm.add(llvm::createCorrelatedValuePropagationPass());
    fpm.add(llvm::createCFGSimplificationPass());
    fpm.add(llvm::createAggressiveInstCombinerPass());
    fpm.add(llvm::createInstructionCombiningPass());
    fpm.add(llvm::createReassociatePass());
    fpm.add(llvm::createLoopInstSimplifyPass());
    fpm.add(llvm::createLoopSimplifyCFGPass());
    fpm.add(llvm::createLICMPass(100, 250));
    fpm.add(llvm::createLoopRotatePass(0));
    fpm.add(llvm::createLICMPass(100, 250));
    fpm.add(llvm::createSimpleLoopUnswitchLegacyPass());
    fpm.add(llvm::createCFGSimplificationPass());
    fpm.add(llvm::createInstructionCombiningPass());
    fpm.add(llvm::createLoopFlattenPass());
    fpm.add(llvm::createLoopSimplifyCFGPass());
    fpm.add(llvm::createLoopIdiomPass());
    fpm.add(llvm::createIndVarSimplifyPass());
    fpm.add(llvm::createLoopDeletionPass());
    fpm.add(llvm::createLoopInterchangePass());
    fpm.add(llvm::createSimpleLoopUnrollPass(3, false, false));
    fpm.add(llvm::createMergedLoadStoreMotionPass());
    fpm.add(llvm::createGVNPass(false));
    fpm.add(llvm::createBitTrackingDCEPass());
    fpm.add(llvm::createAggressiveDCEPass());
    fpm.add(llvm::createDeadStoreEliminationPass());
    fpm.add(llvm::createCFGSimplificationPass());
    fpm.add(llvm::createInstructionCombiningPass());
    fpm.add(llvm::createDeadStoreEliminationPass()); // added
    fpm.add(llvm::createCFGSimplificationPass());    // added
    fpm.add(llvm::createInstructionCombiningPass()); // added
    fpm.add(llvm::createCFGSimplificationPass());    // added
    fpm.add(llvm::createDeadStoreEliminationPass()); // added
    fpm.add(llvm::createLoopUnrollPass());

    // llvm::PassManagerBuilder pmb;
    // pmb.OptLevel = opt;
    // pmb.SizeLevel = size;
    // pmb.DisableUnrollLoops = false;
    // pmb.RerollLoops = false;
    // pmb.SLPVectorize = false;
    // pmb.LoopVectorize = false;
    // pmb.Inliner = llvm::createFunctionInliningPass();
    // pmb.populateFunctionPassManager(fpm);
    // pmb.populateModulePassManager(mpm);
    fpm.doInitialization();
    auto min_num_ins = f_stub->getInstructionCount();
    bool modified = true;
    do
    {
        llvm::outs() << "[+] Ran optimization\n";
        modified = false;
        fpm.run(*f_stub);
        auto num_ins = f_stub->getInstructionCount();
        if (num_ins < min_num_ins)
        {
            min_num_ins = num_ins;
            modified = true;
        }
            
    } while (modified);
    
    fpm.doFinalization();
    mpm.run(*module.get());
}

void lifter::emit_add_ptr(int8_t diff)
{
    llvm::CallInst::Create(module->getFunction("emit_add_ptr"), { ptr, llvm::ConstantInt::get(llvm::Type::getInt8Ty(module->getContext()), diff) }, "", cur_block);
}

void lifter::emit_add(int8_t diff)
{
    llvm::CallInst::Create(module->getFunction("emit_add"), { data, ptr, llvm::ConstantInt::get(llvm::Type::getInt8Ty(module->getContext()), diff) }, "", cur_block);
}

void lifter::emit_putc()
{
    llvm::CallInst::Create(module->getFunction("emit_putchar"), { data, ptr }, "", cur_block);
}

void lifter::emit_getc()
{
    llvm::CallInst::Create(module->getFunction("emit_getchar"), { data, ptr }, "", cur_block);
}

void lifter::emit_loop_start()
{
    auto cond_br = llvm::BasicBlock::Create(module->getContext(), "", cur_block->getParent());
    auto body_br = llvm::BasicBlock::Create(module->getContext(), "", cur_block->getParent());
    auto end_br  = llvm::BasicBlock::Create(module->getContext(), "", cur_block->getParent());
    llvm::IRBuilder<> ir(cur_block);

    ir.CreateBr(cond_br);
    ir.SetInsertPoint(cond_br);

    auto val = ir.CreateCall(module->getFunction("fetch_memory"), { data, ptr });
    auto cmp = ir.CreateICmpNE(val, ir.getInt8(0));
    ir.CreateCondBr(cmp, body_br, end_br);
    ir.SetInsertPoint(body_br);

    loops.push({ cond_br, body_br, end_br });

    cur_block = body_br;
}

void lifter::emit_loop_end()
{
    assert(!loops.empty());
    auto loop = loops.top();
    loops.pop();

    llvm::IRBuilder<> ir(cur_block);
    
    ir.CreateBr(loop.cond_block);
    ir.SetInsertPoint(loop.end_block);
    cur_block = loop.end_block;
}