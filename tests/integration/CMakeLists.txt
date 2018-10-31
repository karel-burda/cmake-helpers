cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(integration-tests VERSION 0.9.0 LANGUAGES NONE)

set(SRCS
    gtest.test.cmake
    run-all-integration-tests.cmake)

if(INTEGRATION-TESTS)
    include("run-all-integration-tests.cmake")

    include(${CMAKE_SOURCE_DIR}/cmake-helpers/code-coverage.cmake)

    add_executable(${PROJECT_NAME} ${SRCS})

    enable_language(C CXX)
    target_sources(${PROJECT_NAME} PRIVATE gtest.cpp)

    _gtest_bootstrap_and_link(${PROJECT_NAME} "")

    _coverage_add_build_options(${PROJECT_NAME})
else()
    add_custom_target(${PROJECT_NAME} ${SRCS})
endif()
