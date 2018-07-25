cmake_minimum_required(VERSION 3.0)

project(cmake-helpers VERSION 0.1.0 LANGUAGES NONE)

file(GLOB_RECURSE SRCS cmake-helpers/*.cmake)

add_custom_target(${PROJECT_NAME} SOURCES ${SRCS} README.md)

add_subdirectory(tests/unit)
