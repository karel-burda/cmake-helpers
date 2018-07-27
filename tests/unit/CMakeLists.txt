cmake_minimum_required(VERSION 3.6 FATAL_ERROR)

project(unit-tests VERSION 0.5.0 LANGUAGES NONE)

set(SRCS
    messages.test.cmake
    source-group-by-folder.test.cmake
    standard-settings.test.cmake
    warnings.test.cmake
    run-all-unit-tests.cmake)

add_custom_target(${PROJECT_NAME} SOURCES ${SRCS})

if(${RUN_UNIT_TESTS})
    include("run-all-unit-tests.cmake")
endif()
