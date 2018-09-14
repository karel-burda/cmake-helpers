cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(integration-tests VERSION 0.8.1 LANGUAGES NONE)

set(SRCS
    get-windows-version.test.cmake
    gtest.test.cmake
    run-all-integration-tests.cmake)

if(${RUN_INTEGRATION_TESTS})
    include("run-all-integration-tests.cmake")

    include(${CMAKE_SOURCE_DIR}/cmake-helpers/messages.cmake)
    include(${CMAKE_SOURCE_DIR}/cmake-helpers/threads.cmake)

    add_executable(${PROJECT_NAME} ${SRCS})

    enable_language(C CXX)
    target_sources(${PROJECT_NAME} PRIVATE gtest.cpp)

    add_dependencies(${PROJECT_NAME} gtest-build)

    _gtest_resolve_build_options(${PROJECT_NAME})
else()
    add_custom_target(${PROJECT_NAME} ${SRCS})
endif()
