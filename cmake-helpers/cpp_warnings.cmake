# Adds pedantic compiler warnings settings to given target
macro(burda_cmake_helpers_cpp_warnings_add_pedantic_level _target _visibility)
    message(STATUS "Running 'burda_cmake_helpers_cpp_warnings_add_pedantic_level' with these params: target='${_target}'")

    target_compile_options(${_target}
                               ${_visibility}
                                   $<$<CXX_COMPILER_ID:MSVC>:
                                       /W4>

                                   $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:
                                       -Wall
                                       -pedantic
                                       -Wno-long-long>)
endmacro()

# Supresses given compiler warning (e.g. when given "keyword-macro" it adds "-Wno-keyword-macro") to desired target
macro(burda_cmake_helpers_cpp_warnings_suppress _target _warning _visibility)
    message(STATUS "Running 'burda_cmake_helpers_warnings_suppress' with these params: target='${_target}', warning='${_warning}'")

    if (NOT CMAKE_CXX_COMPILER_ID MATCHES "GNU" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        message(WARNING "Only GNU and Clang compilers are supported in this macro")
    endif()

    target_compile_options(${_target}
                               ${_visibility}
                                   $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:
                                       -Wno-${_warning}>)
endmacro()
