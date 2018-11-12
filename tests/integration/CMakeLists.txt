cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(integration-tests LANGUAGES CXX)

if (NOT CMAKE_BUILD_TYPE)
    message("CMAKE_BUILD_TYPE undefined, setting it to 'Debug'")

    set(CMAKE_BUILD_TYPE Debug)
endif()

add_executable(${PROJECT_NAME})

target_sources(${PROJECT_NAME}
                   PRIVATE
                       ${CMAKE_CURRENT_SOURCE_DIR}/cpp_coverage_test.cmake
                       ${CMAKE_CURRENT_SOURCE_DIR}/cpp_gtest_test.cmake
                       ${CMAKE_CURRENT_SOURCE_DIR}/cpp_warnings_test.cmake

                       ${CMAKE_CURRENT_SOURCE_DIR}/check_flags_in_makefile.sh
                       ${CMAKE_CURRENT_SOURCE_DIR}/check_coverage_files.sh

                       ${CMAKE_CURRENT_SOURCE_DIR}/code_coverage_test.hpp
                       ${CMAKE_CURRENT_SOURCE_DIR}/integration_test.cpp)

target_compile_features(${PROJECT_NAME}
                            PRIVATE
                                cxx_std_11)

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
