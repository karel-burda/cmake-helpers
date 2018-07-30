# Place this macro before the "add_executable" or "add_library" call
macro(_download_and_build_gtest _GTEST_TARGET_NAME _GTEST_BUILD_VARIANT _GTEST_SOURCE_DIR_NAME _REVISION)
    set(_GTEST_SOURCE_DIR "${CMAKE_BINARY_DIR}/${_GTEST_SOURCE_DIR_NAME}")

    add_custom_target(${_GTEST_TARGET_NAME} SOURCES "")

    # We cannot use "ExternalProject_Add", since there's no options to disable submodules  
    # and this causes problems mainly on Windows version of git
    if(NOT EXISTS "${_GTEST_SOURCE_DIR}")
        # cannot do shallow clone because of later force checkout
        execute_process(COMMAND git clone https://github.com/google/googletest.git ${_GTEST_SOURCE_DIR_NAME}
                    WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
    endif()

    add_custom_command(TARGET ${_GTEST_TARGET_NAME} PRE_BUILD
                       COMMAND git checkout -f ${_REVISION}
                       WORKING_DIRECTORY ${_GTEST_SOURCE_DIR})
    add_custom_command(TARGET ${_GTEST_TARGET_NAME} POST_BUILD
                       COMMAND ${CMAKE_COMMAND} -DBUILD_GMOCK:BOOL=OFF -DBUILD_GTEST:BOOL=ON -DCMAKE_BUILD_TYPE=${_GTEST_BUILD_VARIANT} .
                       WORKING_DIRECTORY ${_GTEST_SOURCE_DIR})
    add_custom_command(TARGET ${_GTEST_TARGET_NAME} POST_BUILD
                       COMMAND ${CMAKE_COMMAND} --build . --config ${_GTEST_BUILD_VARIANT}
                       WORKING_DIRECTORY ${_GTEST_SOURCE_DIR})

    # deliberately not using "target_include_directories" because of integration tests (would throw incompatible target error)
    include_directories(${PROJECT_NAME} SYSTEM ${_GTEST_SOURCE_DIR}/googletest/include)
    link_directories(${PROJECT_NAME} ${_GTEST_SOURCE_DIR}/googletest)
    link_directories(${PROJECT_NAME} ${_GTEST_SOURCE_DIR}/googletest/${_GTEST_BUILD_VARIANT})
endmacro()

macro(_add_compile_options_for_gtest)
    if (WIN32)
        target_compile_options(${PROJECT_NAME} PUBLIC "/MT")
    endif()
endmacro()
