# ------------------------------------------------------------
# This file defines the CMake for Google Test integration
#
# The 'LICENSE.txt' file in the project root holds the software license.
# Copyright (C) 2020 headcode.space
# https://www.headcode.space, <info@headcode.space>
# ------------------------------------------------------------


# ------------------------------------------------------------
# if you do not have googletest installed or downloaded, do a 
#       $ git submodule init
#       $ git submodule add https://github.com/google/googletest 3rd/googletest
# in the project root.
# ------------------------------------------------------------


# Google Test seems to have a dependency on pthreads...
check_library_exists(pthread pthread_kill "/usr/local/lib;/usr/lib;/lib" HAVE_PTHREAD_LIB)
if (HAVE_PTHREAD_LIB)
    set(CMAKE_REQUIRED_LIBRARIES "pthread;${CMAKE_REQUIRED_LIBRARIES}")
endif ()

set(GTEST_BUILD_NEEDED "false")
if (NOT DEFINED GTEST_INCLUDE_DIR)
    set(GTEST_BUILD_NEEDED "true")
endif()
if (NOT DEFINED GTEST_LIBRARY)
    set(GTEST_BUILD_NEEDED "true")
endif()
if (NOT DEFINED GTEST_MAIN_LIBRARY)
    set(GTEST_BUILD_NEEDED "true")
endif()
if (NOT DEFINED GMOCK_LIBRARY)
    set(GTEST_BUILD_NEEDED "true")
endif()
if (NOT DEFINED GMOCK_MAIN_LIBRARY)
    set(GTEST_BUILD_NEEDED "true")
endif()
message(STATUS "GTEST_BUILD_NEEDED: ${GTEST_BUILD_NEEDED}")

if (GTEST_BUILD_NEEDED STREQUAL "true")

    message(STATUS "Needing submodule build of Google Test files (includes, gtest libs and gmock libs).")
    if (NOT DEFINED GTEST_SOURCE_DIR)
        set(GTEST_SOURCE_DIR ${CMAKE_SOURCE_DIR}/3rd/googletest)
    endif()
    message(STATUS "Searching for GTest files in ${GTEST_SOURCE_DIR}")

    if (NOT EXISTS "${GTEST_SOURCE_DIR}/CMakeLists.txt")
        message(FATAL_ERROR "The git submodule for googletest has not been downloaded!")
    endif ()

    file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/3rd/googletest")
    execute_process(COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" "${GTEST_SOURCE_DIR}"
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/3rd/googletest"
    )
    execute_process(COMMAND "${CMAKE_COMMAND}" --build .
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/3rd/googletest"
    )

    set(GTEST_INCLUDE_DIR
        "${GTEST_SOURCE_DIR}/googletest/include"
        "${GTEST_SOURCE_DIR}/googlemock/include"
    )
    set(GTEST_LIBRARY_PATH  "${CMAKE_BINARY_DIR}/3rd/googletest/lib")
    set(GTEST_LIBRARY       "${GTEST_LIBRARY_PATH}/libgtest.a")
    set(GTEST_MAIN_LIBRARY  "${GTEST_LIBRARY_PATH}/libgtest_main.a")
    set(GMOCK_LIBRARY       "${GTEST_LIBRARY_PATH}/libgmock.a")
    set(GMOCK_MAIN_LIBRARY  "${GTEST_LIBRARY_PATH}/libgmock_main.a")

else()
    message(STATUS "Found Google Test files (includes, gtest libs and gmock libs).")
endif()

find_package(GTest REQUIRED)
