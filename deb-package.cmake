# ------------------------------------------------------------
# This file defines the CMake DEB package creation
#
# The 'LICENSE.txt' file in the project root holds the software license.
# Copyright (C) 2020-2021 headcode.space, Oliver Maurhart <info@headcode.space>, https://www.headcode.space
# ------------------------------------------------------------

set(CPACK_GENERATOR "DEB")
if (NOT DEFINED PACKAGE_DEB_CONTROL_DIR)
    set(PACKAGE_DEB_CONTROL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/deb-package)
endif()

foreach(CONTROL_FILE IN ITEMS conffiles;preinst;postinst;prerm;postrm)
    if (EXISTS ${PACKAGE_DEB_CONTROL_DIR}/${CONTROL_FILE})
        if (CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA) 
            set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA "${PACKAGE_DEB_CONTROL_DIR}/${CONTROL_FILE}")
        else ()
            set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA "${CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA};${PACKAGE_DEB_CONTROL_DIR}/${CONTROL_FILE}")
        endif () 
    endif ()
endforeach()

if (DEFINED CPACK_SYSTEM_NAME)
    set(CPACK_SYSTEM_NAME "_${CPACK_SYSTEM_NAME}")
else()
    set(CPACK_SYSTEM_NAME "")
endif()

string(TOLOWER "${CPACK_PACKAGE_NAME}" CPACK_PACKAGE_NAME_LOWERCASE)
set(CPACK_PROJECT_VERSION_STRING "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}")
find_program(DPKG_PROGRAM dpkg DOC "dpkg program of Debian-based systems")
if (DPKG_PROGRAM)
    # use dpkg to fix the package file name
    execute_process(
            COMMAND ${DPKG_PROGRAM} --print-architecture
            OUTPUT_VARIABLE CPACK_DEBIAN_PACKAGE_ARCHITECTURE
            OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME_LOWERCASE}_${CPACK_PROJECT_VERSION_STRING}${CPACK_SYSTEM_NAME}_${CPACK_DEBIAN_PACKAGE_ARCHITECTURE}")
    set(PACKAGE_ARCH ${CPACK_DEBIAN_PACKAGE_ARCHITECTURE})
else ()
    set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME_LOWERCASE}_${CPACK_PROJECT_VERSION_STRING}${CPACK_SYSTEM_NAME}_${CPACK_SYSTEM_NAME}_${CMAKE_HOST_SYSTEM_PROCESSOR}")
    set(PACKAGE_ARCH ${CMAKE_HOST_SYSTEM_PROCESSOR})
endif ()
message(STATUS "Package filename: ${CPACK_PACKAGE_FILE_NAME}.deb.")
