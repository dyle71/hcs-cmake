# ------------------------------------------------------------
# This file defines the CMake RPM package creation for crypt
#
# The 'LICENSE.txt' file in the project root holds the software license.
# Copyright (C) 2020-2021 headcode.space, Oliver Maurhart <info@headcode.space>, https://www.headcode.space
# ------------------------------------------------------------

set(CPACK_GENERATOR "RPM")
if (NOT DEFINED PACKAGE_RPM_CONTROL_DIR)
    set(PACKAGE_RPM_CONTROL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/rpm-package)
endif()

if (EXISTS "${PACKAGE_RPM_CONTROL_DIR}/preinst")
    set(CPACK_RPM_PRE_INSTALL_SCRIPT_FILE "${PACKAGE_RPM_CONTROL_DIR}/preinst")
endif()
if (EXISTS "${PACKAGE_RPM_CONTROL_DIR}/prerm")
    set(CPACK_RPM_PRE_UNINSTALL_SCRIPT_FILE "${PACKAGE_RPM_CONTROL_DIR}/prerm")
endif()
if (EXISTS "${PACKAGE_RPM_CONTROL_DIR}/postinst")
    set(CPACK_RPM_POST_INSTALL_SCRIPT_FILE "${PACKAGE_RPM_CONTROL_DIR}/postinst")
endif()
if (EXISTS "${PACKAGE_RPM_CONTROL_DIR}/postrm")
    set(CPACK_RPM_POST_UNINSTALL_SCRIPT_FILE "${PACKAGE_RPM_CONTROL_DIR}/postrm")
endif()

if (DEFINED CPACK_SYSTEM_NAME)
    set(CPACK_SYSTEM_NAME "_${CPACK_SYSTEM_NAME}")
else()
    set(CPACK_SYSTEM_NAME "")
endif()

string(TOLOWER "${CPACK_PACKAGE_NAME}" CPACK_PACKAGE_NAME_LOWERCASE)
set(CPACK_PROJECT_VERSION_STRING "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}")
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME_LOWERCASE}_${CPACK_PROJECT_VERSION_STRING}${CPACK_SYSTEM_NAME}_${CMAKE_HOST_SYSTEM_PROCESSOR}")
set(PACKAGE_ARCH ${CMAKE_HOST_SYSTEM_PROCESSOR})
message(STATUS "Package filename: ${CPACK_PACKAGE_FILE_NAME}.rpm.")
