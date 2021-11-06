#include <vector>
#include <iostream>
#include <fstream>
#include <memory>
#include <string>
#include <llvm/IR/Module.h>

#include <llvm/Support/CommandLine.h>
#include <llvm/IRReader/IRReader.h>

#include "lifter.hpp"

llvm::cl::opt<std::string> intrin_path("i",
    llvm::cl::desc("Path to the compiled LLVM intrinsics"),
    llvm::cl::value_desc("path"), llvm::cl::Required);

llvm::cl::opt<std::string> brainfuck_path("bf",
    llvm::cl::desc("Path to the brainfuck code"),
    llvm::cl::value_desc("path"), llvm::cl::Required);

llvm::cl::opt<std::string> output_path("o",
    llvm::cl::desc("Output ll path"),
    llvm::cl::value_desc("path"), llvm::cl::Required);


static std::vector<char> read_file(const std::string& path)
{
    std::ifstream file(path, std::ios::binary);

    file.seekg(0, std::ios_base::end);
    std::streampos length = file.tellg();
    file.seekg(0, std::ios_base::beg);

    std::vector<char> buffer(length / sizeof(char));
    file.read(buffer.data(), length);
    return buffer;
}

int main(int argc, char** argv)
{
    // Parse the command line arguments
    llvm::cl::ParseCommandLineOptions(argc, argv);

    llvm::LLVMContext context;

    llvm::outs() << "[+] Intrin: " << intrin_path << "\n";
    llvm::outs() << "[+] BrainFuck: " << brainfuck_path << "\n";

    llvm::SMDiagnostic err;
    auto parsed_intrin = llvm::parseIRFile(intrin_path, err, context);
    if (!parsed_intrin)
        llvm::report_fatal_error("Failed to parse intrinsics file");

    std::shared_ptr<llvm::Module> module = std::move(parsed_intrin);

    lifter bf_lifter(module);

    auto bf_code = read_file(brainfuck_path);

    for (const auto& c : bf_code)
        bf_lifter.lift_instruction(c);
    bf_lifter.terminate();
    
    bf_lifter.optimize();

    bf_lifter.dump(output_path);
    return 0;
}