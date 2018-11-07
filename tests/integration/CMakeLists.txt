cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(integration-tests LANGUAGES NONE)

option(INTEGRATION-TESTS "Perform integration tests (builds as a C++ project)" OFF)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

set(SRCS
    coverage_test.cmake
    gtest_test.cmake
    warnings_test.cmake

    check_flags_in_makefile.sh
    check_coverage_files.sh)

if(INTEGRATION-TESTS)
    add_executable(${PROJECT_NAME} ${SRCS})

    enable_language(CXX)
    target_sources(${PROJECT_NAME} PRIVATE integration_test.cpp)
    set_target_properties(${PROJECT_NAME} PROPERTIES
                                            CXX_STANDARD 11
                                            CXX_STANDARD_REQUIRED TRUE
                                            CMAKE_CXX_EXTENSIONS FALSE)

    include(coverage_test.cmake)
    include(gtest_test.cmake)
    include(warnings_test.cmake)

    if (UNIX)
        if (CMAKE_GENERATOR MATCHES "Unix Makefiles")
            add_custom_command(TARGET ${PROJECT_NAME}
                               PRE_BUILD
                               COMMAND sh ${CMAKE_CURRENT_SOURCE_DIR}/check_flags_in_makefile.sh ${CMAKE_CURRENT_BINARY_DIR}
                               COMMENT "Inspecting generated makefile")
        endif()

        add_custom_command(TARGET ${PROJECT_NAME}
                PRE_BUILD
                COMMAND sh ${CMAKE_CURRENT_SOURCE_DIR}/check_coverage_files.sh
                COMMENT "Inspecting coverage files")
    endif()

else()
    add_custom_target(${PROJECT_NAME} ${SRCS})
endif()
