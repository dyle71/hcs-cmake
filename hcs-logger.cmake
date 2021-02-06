# ------------------------------------------------------------
# This file defines the CMake for headcode-logger integration
#
# The 'LICENSE.txt' file in the project root holds the software license.
# Copyright (C) 2021 headcode.space e.U.  
# Oliver Maurhart <info@headcode.space>, https://www.headcode.space
# ------------------------------------------------------------


# ------------------------------------------------------------
# if you do not have hcs-logger installed or downloaded, do a
#       $ git submodule init
#       $ git submodule add https://gitlab.com/headcode.space/logger.git 3rd/hcs-logger
# in the project root.
# ------------------------------------------------------------

if (NOT DEFINED HCS_LOGGER_SOURCE_DIR)
    # expect hcs-logger in 3rd/ subfolder
    set(HCS_LOGGER_SOURCE_DIR ${CMAKE_SOURCE_DIR}/3rd/hcs-logger)
endif()

set(CMAKE_REQUIRED_QUIET_PREVIOUS ${CMAKE_REQUIRED_QUIET})
set(CMAKE_REQUIRED_QUIET "on")
CHECK_INCLUDE_FILE_CXX("headcode/logger/logger.hpp" HCS_LOGGER_INCLUDE)
set(CMAKE_REQUIRED_QUIET ${CMAKE_REQUIRED_QUIET_PREVIOUS})

if ("${HCS_LOGGER_INCLUDE}" STREQUAL "")

    if (NOT EXISTS "${HCS_LOGGER_SOURCE_DIR}/CMakeLists.txt")
        message(FATAL_ERROR "The git submodule for hcs-logger has not been downloaded!")
    endif ()

    message(STATUS "Using hcs-logger found at ${HCS_LOGGER_SOURCE_DIR}...")

    execute_process(COMMAND "${CMAKE_COMMAND}"
            -D HCS_CMAKE=${CMAKE_SOURCE_DIR}/cmake
            -S "${HCS_LOGGER_SOURCE_DIR}"
            -B ${CMAKE_BINARY_DIR}/3rd/hcs-logger
    )
    execute_process(COMMAND "${CMAKE_COMMAND}" --build ${CMAKE_BINARY_DIR}/3rd/hcs-logger
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/3rd/hcs-logger
    )

    set(HCS_LOGGER_INCLUDE_DIR "${HCS_LOGGER_SOURCE_DIR}/include")
    set(HCS_LOGGER_LIB_DIR "${CMAKE_BINARY_DIR}/3rd/hcs-logger/src/lib/")

endif ()

find_library(HCS_LOGGER_LIB hcs-logger HINTS ${CMAKE_BINARY_DIR}/3rd/hcs-logger/src/lib REQUIRED)
