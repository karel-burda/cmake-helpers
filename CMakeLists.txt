cmake_minimum_required(VERSION 3.6 FATAL_ERROR)

project(cmake-helpers VERSION 1.0.0 LANGUAGES NONE)

option(UNIT-TESTS "Run unit tests OFF")
option(INTEGRATION-TESTS "Run integration tests OFF")

add_subdirectory(cmake-helpers)

if (INTEGRATION-TESTS)
    add_subdirectory(tests/integration)
endif()

if (UNIT-TESTS)
    add_subdirectory(tests/unit)
endif()
