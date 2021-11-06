#include <memory>
#include <string>
#include <stack>
#include <llvm/IR/Module.h>
#include <llvm/IR/IRBuilder.h>

struct while_loop
{
    llvm::BasicBlock* cond_block;
    llvm::BasicBlock* body_block;
    llvm::BasicBlock* end_block;
};

struct lifter
{
    explicit lifter(std::shared_ptr<llvm::Module> module);
    void lift_instruction(char c);
    void terminate();
    void optimize();
    void dump(std::string& path);

private:
    std::shared_ptr<llvm::Module> module;
    // Lifted function
    llvm::Function* f_stub = nullptr;
    // Brainfuck data ptr
    llvm::Value* ptr = nullptr;
    // Brainfuck memory
    llvm::Value* data = nullptr;
    
    llvm::BasicBlock* cur_block = nullptr;
    
    std::stack<while_loop> loops;

    void emit_add_ptr(int8_t diff);
    void emit_add(int8_t diff);
    void emit_putc();
    void emit_getc();
    void emit_loop_start();
    void emit_loop_end();
};