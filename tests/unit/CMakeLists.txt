cmake_minimum_required(VERSION 3.0)

project(unit-tests VERSION 0.1.0 LANGUAGES NONE)

file(GLOB_RECURSE SRCS *.cmake)

add_custom_target(${PROJECT_NAME} SOURCES ${SRCS})
