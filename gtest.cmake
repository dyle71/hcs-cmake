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


if (GTEST_BUILD_NEEDED EQUAL "true")

    message(STATUS "Needing submodule build of Google Test files (includes, gtest libs and gmock libs).")
    
    CHECK_VARIABLE_EXISTS(GTEST_SOURCE_DIR ${CMAKE_SOURCE_DIR}/3rd/googletest)

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