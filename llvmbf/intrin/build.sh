#!/bin/bash

LLVM_PATH="/usr/lib/llvm-12"
TBAAFLAG=true

LLVM_OPTS_64="-I $LLVM_PATH/include/ -fno-discard-value-names -fstrict-aliasing -mno-sse -mno-sse2 -mno-mmx -mtune=generic -fno-vectorize -fno-slp-vectorize -std=c++17 -O3 -g0 -fno-exceptions -fno-rtti -mllvm -enable-tbaa=true -DADDRESS_SIZE_BITS=64"

# Generate the LLVM-IR files
$LLVM_PATH/bin/clang++ intrin.cpp -emit-llvm -S -I $LLVM_OPTS_64 -o intrin_64.ll

# Generate the BITCODE files
$LLVM_PATH/bin/clang++ intrin.cpp -emit-llvm -c -I $LLVM_OPTS_64 -o intrin_64.bc