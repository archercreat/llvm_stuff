include_guard()

# Change these defaults to point to your infrastructure if desired
set(CMKR_REPO "https://github.com/build-cpp/cmkr" CACHE STRING "cmkr git repository" FORCE)
set(CMKR_TAG "archive_9e1fa5dc" CACHE STRING "cmkr git tag (this needs to be available forever)" FORCE)

# Set these from the command line to customize for development/debugging purposes
set(CMKR_EXECUTABLE "" CACHE FILEPATH "cmkr executable")
set(CMKR_SKIP_GENERATION OFF CACHE BOOL "skip automatic cmkr generation")

# Disable cmkr if generation is disabled
if(DEFINED ENV{CI} OR CMKR_SKIP_GENERATION)
    message(STATUS "[cmkr] Skipping automatic cmkr generation")
    macro(cmkr)
    endmacro()
    return()
endif()

# Disable cmkr if no cmake.toml file is found
if(NOT EXISTS "/home/archer/vmprotect/cmkr/cmake.toml")
    message(AUTHOR_WARNING "[cmkr] Not found: /home/archer/vmprotect/cmkr/cmake.toml")
    macro(cmkr)
    endmacro()
    return()
endif()

# Convert a Windows native path to CMake path
if(CMKR_EXECUTABLE MATCHES "\\\\")
    string(REPLACE "\\" "/" CMKR_EXECUTABLE_CMAKE "")
    set(CMKR_EXECUTABLE "" CACHE FILEPATH "" FORCE)
    unset(CMKR_EXECUTABLE_CMAKE)
endif()

# Helper macro to execute a process (COMMAND_ERROR_IS_FATAL ANY is 3.19 and higher)
function(cmkr_exec)
    execute_process(COMMAND cmkr RESULT_VARIABLE CMKR_EXEC_RESULT)
    if(NOT CMKR_EXEC_RESULT EQUAL 0)
        message(FATAL_ERROR "cmkr_exec(cmkr) failed (exit code )")
    endif()
endfunction()

# Windows-specific hack (CMAKE_EXECUTABLE_PREFIX is not set at the moment)
if(WIN32)
    set(CMKR_EXECUTABLE_NAME "cmkr.exe")
else()
    set(CMKR_EXECUTABLE_NAME "cmkr")
endif()

# Use cached cmkr if found
set(CMKR_DIRECTORY "/home/archer/vmprotect/cmkr/build/_cmkr_")
set(CMKR_CACHED_EXECUTABLE "/bin/")

if(NOT CMKR_CACHED_EXECUTABLE STREQUAL CMKR_EXECUTABLE AND CMKR_EXECUTABLE MATCHES "^/home/archer/vmprotect/cmkr/build/_cmkr")
    message(AUTHOR_WARNING "[cmkr] Upgrading '' to ''")
    unset(CMKR_EXECUTABLE CACHE)
endif()

if(CMKR_EXECUTABLE AND EXISTS "")
    message(VERBOSE "[cmkr] Found cmkr: ''")
elseif(CMKR_EXECUTABLE AND NOT CMKR_EXECUTABLE STREQUAL CMKR_CACHED_EXECUTABLE)
    message(FATAL_ERROR "[cmkr] '' not found")
else()
    set(CMKR_EXECUTABLE "" CACHE FILEPATH "Full path to cmkr executable" FORCE)
    message(VERBOSE "[cmkr] Bootstrapping ''")
    
    message(STATUS "[cmkr] Fetching cmkr...")
    if(EXISTS "")
        cmkr_exec("/usr/bin/cmake" -E rm -rf "")
    endif()
    find_package(Git QUIET REQUIRED)
    cmkr_exec(""
        clone
        --config advice.detachedHead=false
        --branch 
        --depth 1
        
        ""
    )
    message(STATUS "[cmkr] Building cmkr...")
    cmkr_exec("/usr/bin/cmake"
        --no-warn-unused-cli
        ""
        "-B/build"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DCMAKE_INSTALL_PREFIX="
        "-DCMKR_GENERATE_DOCUMENTATION=OFF"
    )
    cmkr_exec("/usr/bin/cmake"
        --build "/build"
        --config Release
        --parallel
    )
    cmkr_exec("/usr/bin/cmake"
        --install "/build"
        --config Release
        --prefix ""
        --component cmkr
    )
    if(NOT EXISTS )
        message(FATAL_ERROR "[cmkr] Failed to bootstrap ''")
    endif()
    cmkr_exec("" version)
    message(STATUS "[cmkr] Bootstrapped ")
endif()
execute_process(COMMAND "" version
    RESULT_VARIABLE CMKR_EXEC_RESULT
)
if(NOT CMKR_EXEC_RESULT EQUAL 0)
    message(FATAL_ERROR "[cmkr] Failed to get version, try clearing the cache and rebuilding")
endif()

# This is the macro that contains black magic
macro(cmkr)
    # When this macro is called from the generated file, fake some internal CMake variables
    get_source_file_property(CMKR_CURRENT_LIST_FILE "/home/archer/vmprotect/cmkr/CMakeLists.txt" CMKR_CURRENT_LIST_FILE)
    if(CMKR_CURRENT_LIST_FILE)
        set(CMAKE_CURRENT_LIST_FILE "")
        get_filename_component(CMAKE_CURRENT_LIST_DIR "/home/archer/vmprotect/cmkr/CMakeLists.txt" DIRECTORY)
    endif()

    # File-based include guard (include_guard is not documented to work)
    get_source_file_property(CMKR_INCLUDE_GUARD "/home/archer/vmprotect/cmkr/CMakeLists.txt" CMKR_INCLUDE_GUARD)
    if(NOT CMKR_INCLUDE_GUARD)
        set_source_files_properties("/home/archer/vmprotect/cmkr/CMakeLists.txt" PROPERTIES CMKR_INCLUDE_GUARD TRUE)

        file(SHA256 "/home/archer/vmprotect/cmkr/CMakeLists.txt" CMKR_LIST_FILE_SHA256_PRE)

        # Generate CMakeLists.txt
        cmkr_exec("" gen
            WORKING_DIRECTORY "/home/archer/vmprotect/cmkr"
        )

        file(SHA256 "/home/archer/vmprotect/cmkr/CMakeLists.txt" CMKR_LIST_FILE_SHA256_POST)

        # Delete the temporary file if it was left for some reason
        set(CMKR_TEMP_FILE "/home/archer/vmprotect/cmkr/CMakerLists.txt")
        if(EXISTS "")
            file(REMOVE "")
        endif()

        if(NOT CMKR_LIST_FILE_SHA256_PRE STREQUAL CMKR_LIST_FILE_SHA256_POST)
            # Copy the now-generated CMakeLists.txt to CMakerLists.txt
            # This is done because you cannot include() a file you are currently in
            configure_file(CMakeLists.txt "" COPYONLY)
            
            # Add the macro required for the hack at the start of the cmkr macro
            set_source_files_properties("" PROPERTIES
                CMKR_CURRENT_LIST_FILE "/home/archer/vmprotect/cmkr/CMakeLists.txt"
            )
            
            # 'Execute' the newly-generated CMakeLists.txt
            include("")
            
            # Delete the generated file
            file(REMOVE "")
            
            # Do not execute the rest of the original CMakeLists.txt
            return()
        endif()
        # Resume executing the unmodified CMakeLists.txt
    endif()
endmacro()
