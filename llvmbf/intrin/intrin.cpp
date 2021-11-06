#include <cmath>
#include <cstring>
#include <stdint.h>
#include <stdio.h>
#include <type_traits>
#include <x86intrin.h>

// using size_t& = size_t &__restrict__;
// using uint8_t* = uint8_t *__restrict__;

extern "C" __attribute__((always_inline)) void emit_add_ptr(uint64_t& ptr, int8_t diff)
{
    // Update the pointer
    ptr += diff;
}

extern "C" __attribute__((always_inline)) void emit_add(uint8_t* mem, uint64_t& ptr, int8_t diff)
{
    // Fetch the value
    uint8_t value = mem[ptr];
    // Update the value
    value += diff;
    // Store the value
    mem[ptr] = value;
}

extern "C" __attribute__((always_inline)) void emit_putchar(uint8_t* mem, uint64_t& ptr)
{
    // Fetch the value
    uint8_t value = mem[ptr];
    // Print the value
    putchar(value);
}

extern "C" __attribute__((always_inline)) void emit_getchar(uint8_t* mem, uint64_t& ptr)
{
    // Fetch the value
    uint8_t value = getchar();
    // Store the value
    mem[ptr] = value;
}

extern "C" __attribute__((always_inline)) uint8_t fetch_memory(uint8_t* mem, uint64_t& ptr)
{
    // Fetch the value
    return mem[ptr];
}

extern "C" __attribute__((always_inline)) void stub(uint8_t* mem/*, uint64_t& ptr*/);

extern "C" void lifted()
{
    uint8_t memory[30000] = { 0 };
    // uint64_t ptr = 0;

    stub(memory);
}
