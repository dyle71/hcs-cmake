# ------------------------------------------------------------
# This file defines the CMake for headcode-benchmark integration
#
# The 'LICENSE.txt' file in the project root holds the software license.
# Copyright (C) 2020-2021 headcode.space
# https://www.headcode.space, <info@headcode.space>
# ------------------------------------------------------------


# ------------------------------------------------------------
# if you do not have hcs-benchmark installed or downloaded, do a
#       $ git submodule init
#       $ git submodule add https://gitlab.com/headcode.space/benchmark.git 3rd/hcs-benchmark
# in the project root.
# ------------------------------------------------------------

if (NOT DEFINED HCS_BENCHMARK_SOURCE_DIR)
    set(HCS_BENCHMARK_SOURCE_DIR ${CMAKE_SOURCE_DIR}/3rd/hcs-benchmark)
endif()

set(CMAKE_REQUIRED_QUIET_PREVIOUS ${CMAKE_REQUIRED_QUIET})
set(CMAKE_REQUIRED_QUIET "on")
CHECK_INCLUDE_FILE_CXX("headcode/benchmark/benchmark.hpp" HCS_BENCHMARK_INCLUDE)
set(CMAKE_REQUIRED_QUIET ${CMAKE_REQUIRED_QUIET_PREVIOUS})

if ("${HCS_BENCHMARK_INCLUDE}" STREQUAL "")

    if (NOT EXISTS "${HCS_BENCHMARK_SOURCE_DIR}/CMakeLists.txt")
        message(FATAL_ERROR "The git submodule for hcs-benchmark has not been downloaded!")
    endif ()

    message(STATUS "Using hcs-benchmark found at ${HCS_BENCHMARK_SOURCE_DIR}...")

    execute_process(COMMAND "${CMAKE_COMMAND}"
            -S "${HCS_BENCHMARK_SOURCE_DIR}"
            -B ${CMAKE_BINARY_DIR}/3rd/hcs-benchmark
    )
    execute_process(COMMAND "${CMAKE_COMMAND}" --build ${CMAKE_BINARY_DIR}/3rd/hcs-benchmark
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/3rd/hcs-benchmark
    )

    set(HCS_BENCHMARK_INCLUDE_DIR "${HCS_BENCHMARK_SOURCE_DIR}/include")
    set(HCS_BENCHMARK_LIB_DIR "")

endif ()
