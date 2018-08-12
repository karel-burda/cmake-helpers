cmake_minimum_required(VERSION 3.6 FATAL_ERROR)

project(integration-tests VERSION 0.6.0 LANGUAGES NONE)

set(SRCS
    get-windows-version.test.cmake
    gtest.test.cmake
    run-all-integration-tests.cmake)

add_custom_target(${PROJECT_NAME} SOURCES ${SRCS})

add_executable(gtest_test gtest.cpp)
set_target_properties(gtest_test PROPERTIES LINKER_LANGUAGE CXX)

if(${RUN_INTEGRATION_TESTS})
    include("run-all-integration-tests.cmake")
endif()
