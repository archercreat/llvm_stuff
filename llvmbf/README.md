# brainfuck LLVM lifter

Was written in 2 days on holidays. All handlers except `[` and `]` are written in C++ and compiled into llvm bytecode.

### Usage
```
./build/llvmbf -i intrin/intrin_64.bc --bf samples/helloworld.bf -o helloworld.ll
clang++ -O3 -o helloworld helloworld.ll
./helloworld
Hello World!
```