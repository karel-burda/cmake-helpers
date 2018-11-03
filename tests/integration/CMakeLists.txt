cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(integration-tests LANGUAGES NONE)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

set(SRCS
    coverage.test.cmake
    gtest.test.cmake
    warnings.test.cmake)

if(INTEGRATION-TESTS)
    add_executable(${PROJECT_NAME} ${SRCS})

    enable_language(CXX)
    target_sources(${PROJECT_NAME} PRIVATE integration_test.cpp)

    include(coverage.test.cmake)
    include(gtest.test.cmake)
    include(warnings.test.cmake)
else()
    add_custom_target(${PROJECT_NAME} ${SRCS})
endif()
