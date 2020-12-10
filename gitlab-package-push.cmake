# ------------------------------------------------------------
# This file defines lets you push a packe to a gitlab package registry
#
# The 'LICENSE.txt' file in the project root holds the software license.
# Copyright (C) 2020 headcode.space
# https://www.headcode.space, <info@headcode.space>
# ------------------------------------------------------------

if (DEFINED GITLAB_ACCESS_TOKEN)

    if ("${GITLAB_PACKAGE_URL}" STREQUAL "")
        message(FATAL_ERROR "Cannot push a package without a destination url. Please specify GITLAB_PACKAGE_URL.")
    endif()
    if ("${PACKAGE_FILE}" STREQUAL "")
        message(FATAL_ERROR "Don't know what to push. Please specify PACKAGE_FILE.")
    endif()
    if ("${PACKAGE_FILE_NAME}" STREQUAL "")
        message(FATAL_ERROR "Cannot push a package without file name. Please specify PACKAGE_FILE_NAME.")
    endif()

    find_program(CURL_COMMAND curl PATHS /usr/bin /usr/local/bin REQUIRED)
    add_custom_target(gitlab_push_package
        COMMAND ${CURL_COMMAND} --header "JOB-TOKEN: $CI_JOB_TOKEN" --upload-file "${PACKAGE_FILE}" "${GITLAB_PACKAGE_URL}/${CPACK_PROJECT_VERSION_STRING}/${PACKAGE_FILE_NAME}"
        COMMENT "PUT ${PACKAGE_FILE_NAME} ==> ${GITLAB_PACKAGE_URL}/${CPACK_PROJECT_VERSION_STRING}/${PACKAGE_FILE_NAME}..."
    )

endif()
