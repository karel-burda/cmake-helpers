# Place this macro after the "add_executable" or "add_library" call
macro(_gtest_download_and_build _GTEST_TARGET_NAME _GTEST_BUILD_VARIANT _GTEST_SOURCE_DIR_NAME _REVISION)
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

    link_directories(${_GTEST_SOURCE_DIR}/googletest/${_GTEST_BUILD_VARIANT})
    link_directories(${_GTEST_SOURCE_DIR}/googletest)
endmacro()

macro(_gtest_resolve_build_options _TARGET)
    _gtest_include_headers(${_TARGET})
    _gtest_link(${_TARGET})
    _gtest_add_compile_options(${_TARGET})

    include("threads.cmake")
    _link_threads_if_available(${_TARGET})
endmacro()

macro(_gtest_include_headers _TARGET)
    target_include_directories(${_TARGET} SYSTEM PUBLIC ${_GTEST_SOURCE_DIR}/googletest/include)
endmacro()

macro(_gtest_link _TARGET)
    target_link_libraries(
        ${_TARGET}
            PUBLIC
                gtest
                gtest_main)
endmacro()

macro(_gtest_add_compile_options _TARGET)
    if (MSVC)
        target_compile_options(${_TARGET} PUBLIC /MT)
    endif()

endmacro()
