# ------------------------------------------------------------
# This file defines the CMake for headcode-mem integration
#
# The 'LICENSE.txt' file in the project root holds the software license.
# Copyright (C) 2020 headcode.space
# https://www.headcode.space, <info@headcode.space>
# ------------------------------------------------------------


# ------------------------------------------------------------
# if you do not have hcs-mem installed or downloaded, do a
#       $ git submodule init
#       $ git submodule add https://gitlab.com/headcode.space/memtool.git 3rd/hcs-mem
# in the project root.
# ------------------------------------------------------------

if (NOT DEFINED HCS_MEM_SOURCE_DIR)
    set(HCS_MEM_SOURCE_DIR ${CMAKE_SOURCE_DIR}/3rd/hcs-mem)
endif()

set(CMAKE_REQUIRED_QUIET_PREVIOUS ${CMAKE_REQUIRED_QUIET})
set(CMAKE_REQUIRED_QUIET "on")
CHECK_INCLUDE_FILE_CXX("headcode/mem/mem.hpp" HCS_MEM_INCLUDE)
set(CMAKE_REQUIRED_QUIET ${CMAKE_REQUIRED_QUIET_PREVIOUS})

if ("${HCS_MEM_INCLUDE}" STREQUAL "")

    if (NOT EXISTS "${HCS_MEM_SOURCE_DIR}/CMakeLists.txt")
        message(FATAL_ERROR "The git submodule for hcs-mem has not been downloaded!")
    endif ()

    message(STATUS "Using hcs-mem found at ${HCS_MEM_SOURCE_DIR}...")

    execute_process(COMMAND "${CMAKE_COMMAND}"
            -D HCS_CMAKE=${CMAKE_SOURCE_DIR}/cmake
            -D HCS_BENCHMARK_SOURCE_DIR=${HCS_BENCHMARK_SOURCE_DIR}
            -S "${HCS_MEM_SOURCE_DIR}"
            -B ${CMAKE_BINARY_DIR}/3rd/hcs-mem
    )
    execute_process(COMMAND "${CMAKE_COMMAND}" --build ${CMAKE_BINARY_DIR}/3rd/hcs-mem
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/3rd/hcs-mem
    )

    set(HCS_MEM_INCLUDE_DIR "${HCS_MEM_SOURCE_DIR}/include")
    set(HCS_MEM_LIB_DIR "")

endif ()
