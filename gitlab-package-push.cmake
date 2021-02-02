# ------------------------------------------------------------
# This file defines lets you push a packe to a gitlab package registry
#
# The 'LICENSE.txt' file in the project root holds the software license.
# Copyright (C) 2020-2021 headcode.space e.U.  
# Oliver Maurhart <info@headcode.space>, https://www.headcode.space
# ------------------------------------------------------------

if ("${PACKAGE_FILE}" STREQUAL "")
    message(FATAL_ERROR "Don't know what to push. Please specify PACKAGE_FILE.")
endif()
if ("${PACKAGE_FILE_NAME}" STREQUAL "")
    message(FATAL_ERROR "Cannot push a package without file name. Please specify PACKAGE_FILE_NAME.")
endif()
if ("${GITLAB_PACKAGE_GROUP_NAME}" STREQUAL "")
    set(GITLAB_PACKAGE_GROUP_NAME ${CMAKE_PROJECT_NAME})
endif()

if (NOT DEFINED CI_API_V4_URL)
    set(CI_API_V4_URL "https://gitlab.com/api/v4")
endif()


set(GITLAB_PACKAGE_URL "${GITLAB_PACKAGE_BASE_URL}/${CPACK_PROJECT_VERSION_STRING}/${PACKAGE_FILE_NAME}")
message(STATUS "GITLAB_PACKAGE_URL: ${GITLAB_PACKAGE_URL}")
find_program(CURL_COMMAND curl PATHS /usr/bin /usr/local/bin REQUIRED)
add_custom_target(gitlab_push_package
    COMMAND ${CURL_COMMAND} --header "JOB-TOKEN: ${CI_JOB_TOKEN}" -X DELETE "${GITLAB_PACKAGE_URL}"
    COMMAND ${CURL_COMMAND} --header "JOB-TOKEN: ${CI_JOB_TOKEN}" -X PUT --upload-file "${PACKAGE_FILE}" "${GITLAB_PACKAGE_URL}"
    COMMENT "PUT ${PACKAGE_FILE_NAME} ==> ${GITLAB_PACKAGE_URL}..."
)
