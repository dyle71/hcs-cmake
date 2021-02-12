# ------------------------------------------------------------
# This file creates the run-gcovr target which does a profiling.
#
# The 'LICENSE.txt' file in the project root holds the software license.
# Copyright (C) 2021 headcode.space e.U.  
# Oliver Maurhart <info@headcode.space>, https://www.headcode.space
# ------------------------------------------------------------

# ------------------------------------------------------------
# profiling for coverage tests

# This will put up a target called 'run-gcovr'.
# After a build and running tests, you may then invoke
#
#   $ make run-gcovr
#
# in the build folder to collect code coverage results:
#
#   * gcovr-coverage.info
#   * gcovr-report.xml
#   * gcovr-sonarqube-report.xml
#   * coverage-html


option(PROFILING_MODE_ENABLED "enable profiling mode" off)
if (PROFILING_MODE_ENABLED)

    find_program(GCOVR "gcovr" REQUIRED)
    find_program(LCOV "lcov" REQUIRED)
    find_program(GENHTML "genhtml" REQUIRED)

    message(STATUS "Profiling mode enabled")
    set(COMPILER_FLAGS_PROFILING "-pg --coverage")
    set(LINKER_FLAGS_PROFILING "-lgcov")
    set(COVERAGE_EXCLUDE_DIRS "'/usr/include/*' '/usr/lib/*' '${CMAKE_SOURCE_DIR}/3rd/*'")
    set(COVERAGE_INFO_FILE ${CMAKE_BINARY_DIR}/gcovr-coverage.info)
    set(COVERAGE_REPORT_FILE ${CMAKE_BINARY_DIR}/gcovr-report.xml)
    set(COVERAGE_SONARQUBE_REPORT_FILE ${CMAKE_BINARY_DIR}/gcovr-sonarqube-report.xml)

    add_custom_target(run-gcovr
        COMMAND ${GCOVR} -r ${CMAKE_SOURCE_DIR} --exclude-throw-branches -e ${CMAKE_SOURCE_DIR}/3rd -e ${CMAKE_SOURCE_DIR}/test -x -o ${COVERAGE_REPORT_FILE}
        COMMAND ${GCOVR} -r ${CMAKE_SOURCE_DIR} --exclude-throw-branches -e ${CMAKE_SOURCE_DIR}/3rd -e ${CMAKE_SOURCE_DIR}/test -x --sonarqube ${COVERAGE_SONARQUBE_REPORT_FILE}
        COMMAND ${GCOVR} -r ${CMAKE_SOURCE_DIR} --exclude-throw-branches -e ${CMAKE_SOURCE_DIR}/3rd -e ${CMAKE_SOURCE_DIR}/test
        COMMAND ${LCOV} -c --directory ${CMAKE_BINARY_DIR} --output-file ${COVERAGE_INFO_FILE}
        COMMAND ${LCOV} --remove ${COVERAGE_INFO_FILE} '/usr/include/*' --output-file ${COVERAGE_INFO_FILE} -q
        COMMAND ${LCOV} --remove ${COVERAGE_INFO_FILE} '/usr/lib/*' --output-file ${COVERAGE_INFO_FILE} -q
        COMMAND ${LCOV} --remove ${COVERAGE_INFO_FILE} '${CMAKE_SOURCE_DIR}/3rd/*' --output-file ${COVERAGE_INFO_FILE} -q
        COMMAND ${LCOV} --remove ${COVERAGE_INFO_FILE} '${CMAKE_SOURCE_DIR}/test/*' --output-file ${COVERAGE_INFO_FILE} -q
        COMMAND ${GENHTML} ${COVERAGE_INFO_FILE} --output-directory coverage-html
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMENT "Running gcovr"
    )
else ()
    message(STATUS "Profiling mode disabled")
endif ()
