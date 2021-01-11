# ------------------------------------------------------------
# This file defines the CMake for argparse integration
#
# The 'LICENSE.txt' file in the project root holds the software license.
# Copyright (C) 2020-2021 headcode.space
# https://www.headcode.space, <info@headcode.space>
# ------------------------------------------------------------


# ------------------------------------------------------------
# if you do not have googletest installed or downloaded, do a
#       $ git submodule init
#       $ git submodule add https://github.com/p-ranav/argparse.git 3rd/argparse
# in the project root.
# ------------------------------------------------------------


if (NOT DEFINED ARGPARSE_SOURCE_DIR)
    set(ARGPARSE_SOURCE_DIR ${CMAKE_SOURCE_DIR}/3rd/argparse)
endif()

set(CMAKE_REQUIRED_QUIET_PREVIOUS ${CMAKE_REQUIRED_QUIET})
set(CMAKE_REQUIRED_QUIET "on")
CHECK_INCLUDE_FILE_CXX("argparse/argparse.hpp" ARGPARSE_INCLUDE)
set(CMAKE_REQUIRED_QUIET ${CMAKE_REQUIRED_QUIET_PREVIOUS})

if ("${ARGPARSE_INCLUDE}" STREQUAL "")

    if (NOT EXISTS "${ARGPARSE_SOURCE_DIR}/CMakeLists.txt")
        message(FATAL_ERROR "The git submodule for argparse has not been downloaded!")
    endif ()

    message(STATUS "Using argparse found at ${ARGPARSE_SOURCE_DIR}...")

    execute_process(COMMAND "${CMAKE_COMMAND}"
            -S "${ARGPARSE_SOURCE_DIR}"
            -B ${CMAKE_BINARY_DIR}/3rd/argparse
    )
    execute_process(COMMAND "${CMAKE_COMMAND}" --build ${CMAKE_BINARY_DIR}/3rd/argparse
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/3rd/argparse
    )

    set(ARGPARSE_SOURCE_DIR "${ARGPARSE_SOURCE_DIR}/include")
    set(ARGPASRE_LIB_DIR "")

endif ()
