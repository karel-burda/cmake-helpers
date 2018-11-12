cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(cmake-helpers LANGUAGES NONE)

set(SRCS
    cpp_coverage.cmake
    cpp_gtest.cmake
    cpp_warnings.cmake)

add_custom_target(${PROJECT_NAME} SOURCES ${SRCS})
