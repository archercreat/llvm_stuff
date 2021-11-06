#pragma once

#include <llvm/IR/Module.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/NoFolder.h>

#include <iostream>
#include <string>
#include <vector>
#include <cstdio>
#include <filesystem>
#include <fstream>

using namespace llvm;

namespace utils
{
    template<typename... Tx>
    static std::string fmt(const char* fmt, Tx&&... args)
    {
        std::string buffer;
        buffer.resize(snprintf(nullptr, 0, fmt, args...));
        snprintf(buffer.data(), buffer.size() + 1, fmt, std::forward<Tx>(args)...);
        return buffer;
    }

    template<typename  Type = Type, typename Value = uint8_t> requires (std::is_same_v<Type, ArrayType> || std::is_same_v<Type, IntegerType>)
    GlobalVariable* create_global(Module* program, const std::string& name, Type* type, std::vector<Value> value = {0}, size_t offset = 0)
    {
        program->getOrInsertGlobal(name, type);

        auto global = program->getNamedGlobal(name);
        global->setLinkage(GlobalValue::InternalLinkage);

        if constexpr (std::is_same_v<Type, ArrayType>)
        {
            auto elem_type = type->getArrayElementType();
            auto bit_size  = elem_type->getPrimitiveSizeInBits();
            auto capacity  = type->getArrayNumElements();

            auto make_constant = [&elem_type, &bit_size](Value value)
            {
                return Constant::getIntegerValue(elem_type, APInt(bit_size, value));
            };

            std::vector<Constant*> constants(capacity, make_constant(0));
            std::transform(value.begin(), value.end(), constants.begin() + offset, make_constant);
            global->setInitializer(ConstantArray::get(type, makeArrayRef<Constant*>(constants)));
        }
        else if constexpr (std::is_same_v<Type, IntegerType>)
        {
            global->setInitializer(Constant::getIntegerValue(type, APInt(type->getPrimitiveSizeInBits(), value[0])));
        }
        return global;
    }



    BasicBlock* find_block(Function::BasicBlockListType& basic_blocks, const std::string& name)
    {
        for (auto& basic_block: basic_blocks)
        {
            if (basic_block.getName() == name)
            {
                return &basic_block;
            }
        }
        return nullptr;
    }
}