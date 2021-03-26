cmake_minimum_required(VERSION 3.17)
project(sprushVM)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# find llvm
find_package(LLVM REQUIRED CONFIG HINTS "${LLVM_DIR}" NO_CMAKE_FIND_ROOT_PATH)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "LLVM libraries: ${LLVM_LIBRARIES}")
# add optimizations
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -march=native")

# Find the libraries that correspond to the LLVM components that we wish to use
set(LLVM_LIBRARIES
        LLVMCore
        LLVMSupport
        LLVMPasses
        LLVMIRReader
        LLVMExecutionEngine
        LLVMX86AsmParser
        LLVMX86CodeGen
        LLVMTarget
        LLVMInterpreter)

message(STATUS "LLVM libraries: ${LLVM_LIBRARIES}")
message(STATUS "LLVM includes: ${LLVM_INCLUDE_DIRS}")
message(STATUS "LLVM definitions: ${LLVM_DEFINITIONS}")
message(STATUS "LLVM tools: ${LLVM_TOOLS_BINARY_DIR}")


add_executable(sprushVM src/main.cpp src/utils.hpp src/instructions.hpp)

target_link_libraries(${PROJECT_NAME} PUBLIC ${LLVM_LIBRARIES})
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(${PROJECT_NAME} SYSTEM PUBLIC ${LLVM_INCLUDE_DIRS})
target_compile_definitions(${PROJECT_NAME} PUBLIC ${LLVM_DEFINITIONS} ${GLOBAL_DEFINITIONS} -DNOMINMAX)
target_compile_options(${PROJECT_NAME} PUBLIC ${GLOBAL_CXXFLAGS})

set_property(TARGET ${PROJECT_NAME} PROPERTY POSITION_INDEPENDENT_CODE ON)