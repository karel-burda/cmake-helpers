cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(integration-tests LANGUAGES CXX)

if (NOT CMAKE_BUILD_TYPE)
    message("CMAKE_BUILD_TYPE undefined, setting it to 'Debug'")

    set(CMAKE_BUILD_TYPE Debug)
endif()

add_executable(${PROJECT_NAME} "")

target_sources(${PROJECT_NAME}
                   PRIVATE
                       cpp_coverage_test.cmake
                       cpp_gtest_test.cmake
                       cpp_warnings_test.cmake

                       check_flags_in_makefile.sh
                       check_coverage_files.sh

                       code_coverage_test.hpp
                       integration_test.cpp)

set_target_properties(${PROJECT_NAME}
                          PROPERTIES
                              CXX_STANDARD 11
                              CXX_STANDARD_REQUIRED TRUE
                              CMAKE_CXX_EXTENSIONS FALSE)

# Needed for the code coverage better results
target_compile_options(${PROJECT_NAME}
                            PRIVATE
                                $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:
                                    -fno-inline -fno-inline-small-functions -fno-default-inline>)

include(cpp_coverage_test.cmake)
include(cpp_gtest_test.cmake)
include(cpp_warnings_test.cmake)

if (UNIX)
    if (CMAKE_GENERATOR MATCHES "Unix Makefiles")
        add_custom_command(TARGET ${PROJECT_NAME}
                           PRE_BUILD
                           COMMAND bash ${CMAKE_CURRENT_SOURCE_DIR}/check_flags_in_makefile.sh ${CMAKE_CURRENT_BINARY_DIR}
                           COMMENT "Inspecting generated makefile")
        endif()

        add_custom_target(check-coverage-files
                          COMMAND bash ${CMAKE_CURRENT_SOURCE_DIR}/check_coverage_files.sh
                          WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                          COMMENT "Inspecting coverage files")
endif()
