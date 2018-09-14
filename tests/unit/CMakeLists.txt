cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(unit-tests VERSION 0.8.1 LANGUAGES NONE)

set(SRCS
    messages.test.cmake
    source-group-by-folder.test.cmake
    standard-settings.test.cmake
    warnings.test.cmake
    run-all-unit-tests.cmake)

add_custom_target(${PROJECT_NAME} SOURCES ${SRCS})

add_executable(dummy-cpp-unit dummy.cpp)

if(${RUN_UNIT_TESTS})
    include("run-all-unit-tests.cmake")
endif()
