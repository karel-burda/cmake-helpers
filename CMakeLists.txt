cmake_minimum_required(VERSION 3.6 FATAL_ERROR)

project(cmake-helpers VERSION 0.5.0 LANGUAGES NONE)

add_subdirectory(cmake-helpers)
add_subdirectory(tests/integration)
add_subdirectory(tests/unit)
