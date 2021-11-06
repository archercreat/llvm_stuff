#include "peepholepass.hpp"

#include <llvm/IR/Module.h>
#include <llvm/Support/TypeName.h>

using namespace llvm;

namespace
{

    ConstantInt* get_const_operand(Instruction* ins)
    {
        for (auto* iter = ins->op_begin(); iter != ins->op_end(); iter++)
        {
            if (auto* cint = dyn_cast<ConstantInt>(*iter))
                return cint;
        }
        return nullptr;
    }

    void set_const_operand(Instruction* ins, ConstantInt* new_op)
    {
        for (size_t i = 0; i < ins->getNumOperands(); i++)
        {
            if (auto* cint = dyn_cast<ConstantInt>(ins->getOperand(i)))
            {
                ins->setOperand(i, new_op);
            }
        }
    }

    struct PeepHoleOptimizationPass : public FunctionPass
    {
        static char ID;
        PeepHoleOptimizationPass() : FunctionPass(ID) {}

/*
    call void @emit_add(i8* %0, i64* %1, i8 1)
    call void @emit_add(i8* %0, i64* %1, i8 1)
    --------
    call void @emit_add(i8% %0, i64* %1, i8 2)
*/
        bool runOnFunction(Function& func) override
        {
            bool modified = false;
            std::vector<Instruction*> to_remove;
            for (auto& bb : func)
            {
                for (auto& ins : bb)
                {
                    if (CallInst* call_0 = dyn_cast<CallInst>(&ins))
                    {
                        if (CallInst* call_1 = dyn_cast<CallInst>(ins.getNextNonDebugInstruction()))
                        {
                            if (call_0->getCalledFunction() == call_1->getCalledFunction())
                            {
                                auto op0 = get_const_operand(call_0);
                                auto op1 = get_const_operand(call_1);
                                if (op0 && op1)
                                {
                                    auto new_op = llvm::ConstantInt::get(op0->getType(), op0->getSExtValue() + op1->getSExtValue());
                                    set_const_operand(call_1, new_op);
                                    to_remove.push_back(call_0);
                                    modified = true;
                                }
                            }
                        }
                    }
                }
            }

            for (auto* ins : to_remove)
                ins->removeFromParent();
            if (modified) outs() << "[+] Called\n";
            return modified;
        }
    };

char PeepHoleOptimizationPass::ID = 0;
static RegisterPass<PeepHoleOptimizationPass> X("PeepHoleOptimizationPass",
                                                  "Combine calls to the same handler function",
                                                  false /* Only looks at CFG */,
                                                  false /* Analysis Pass */);

}; // namespace



FunctionPass* createPeepHolePass()
{
    return new PeepHoleOptimizationPass();
}