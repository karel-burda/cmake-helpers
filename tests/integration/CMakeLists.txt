cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(integration-tests VERSION 0.7.0 LANGUAGES NONE)

set(SRCS
    get-windows-version.test.cmake
    gtest.test.cmake
    run-all-integration-tests.cmake)

add_custom_target(${PROJECT_NAME} SOURCES ${SRCS})

add_executable(dummy-cpp-integration gtest.cpp)

if(${RUN_INTEGRATION_TESTS})
    include("run-all-integration-tests.cmake")
endif()
