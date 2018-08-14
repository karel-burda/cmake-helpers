cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(integration-tests VERSION 0.7.0 LANGUAGES NONE)

set(SRCS
    get-windows-version.test.cmake
    gtest.test.cmake
    run-all-integration-tests.cmake)

if(${RUN_INTEGRATION_TESTS})
    include("run-all-integration-tests.cmake")

    add_executable(${PROJECT_NAME} ${SRCS})

    enable_language(C CXX)
    target_sources(${PROJECT_NAME} PRIVATE gtest.cpp)

    target_link_libraries(
        ${PROJECT_NAME}
            PRIVATE
                gtest
                gtest_main)

    add_dependencies(${PROJECT_NAME} gtest-build)

    _add_compile_options_for_gtest(${PROJECT_NAME})
else()
    add_custom_target(${PROJECT_NAME} ${SRCS})
endif()
