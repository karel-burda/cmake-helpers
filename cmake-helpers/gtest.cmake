macro(_download_and_build_gtest _GTEST_TARGET_NAME _GTEST_BUILD_VARIANT _GTEST_SOURCE_DIR_NAME)
    set(_GTEST_SOURCE_DIR "${CMAKE_BINARY_DIR}/${_GTEST_SOURCE_DIR_NAME}")

    add_custom_target(${_GTEST_TARGET_NAME} SOURCES "")

    # We cannot use "ExternalProject_Add", since there's no options to disable submodules  
    # and this causes problems mainly on Windows version of git
    if(NOT EXISTS "${_GTEST_SOURCE_DIR}")
        execute_process(COMMAND git clone --depth=1 https://github.com/google/googletest.git ${_GTEST_SOURCE_DIR_NAME}
                    WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
    endif()

    add_custom_command(TARGET ${_GTEST_TARGET_NAME} PRE_BUILD
                       COMMAND git checkout -f 0957cce368316577aae5ddfffcb67f24621d69e7
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
