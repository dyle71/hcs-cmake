# ------------------------------------------------------------
# This file defines lets you push a packe to a gitlab package registry
#
# The 'LICENSE.txt' file in the project root holds the software license.
# Copyright (C) 2020 headcode.space
# https://www.headcode.space, <info@headcode.space>
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

set(GITLAB_PACKAGE_URL "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/packages/generic/${GITLAB_PACKAGE_GROUP_NAME}")
find_program(CURL_COMMAND curl PATHS /usr/bin /usr/local/bin REQUIRED)
add_custom_target(gitlab_push_package
    COMMAND ${CURL_COMMAND} --header "JOB-TOKEN: $CI_JOB_TOKEN" --upload-file "${PACKAGE_FILE}" "${GITLAB_PACKAGE_URL}/${CPACK_PROJECT_VERSION_STRING}/${PACKAGE_FILE_NAME}"
    COMMENT "PUT ${PACKAGE_FILE_NAME} ==> ${GITLAB_PACKAGE_URL}/${CPACK_PROJECT_VERSION_STRING}/${PACKAGE_FILE_NAME}..."
)
