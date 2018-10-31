cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(scripts LANGUAGES NONE)

set(OTHER
    ../README.md
    ../.travis.yml)

set(SRCS
    code-coverage.cmake
    gtest.cmake
    warnings.cmake)

add_custom_target(${PROJECT_NAME} SOURCES ${SRCS} ${OTHER})
