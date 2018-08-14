cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(cmake-helpers VERSION 0.7.4 LANGUAGES NONE)

set(OTHER
    ../README.md
    ../.travis.yml)

set(SRCS
    get-windows-version.cmake
    gtest.cmake
    messages.cmake
    source-group-by-folder.cmake
    standard-settings.cmake
    threads.cmake
    warnings.cmake)

add_custom_target(${PROJECT_NAME} SOURCES ${SRCS} ${OTHER})
