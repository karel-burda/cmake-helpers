macro(burda_cmake_helpers_cpp_warnings_add_pedantic_level_cxx _target _visibility)
    _burda_cmake_helpers_cpp_warnings_add_pedantic_level(${_target} ${_visibility} CXX)
endmacro()

macro(burda_cmake_helpers_cpp_warnings_add_pedantic_level_c _target _visibility)
    _burda_cmake_helpers_cpp_warnings_add_pedantic_level(${_target} ${_visibility} C)
endmacro()

# Adds pedantic compiler warnings settings to given target
macro(_burda_cmake_helpers_cpp_warnings_add_pedantic_level _target _visibility _language)
    message(STATUS "Running 'burda_cmake_helpers_cpp_warnings_add_pedantic_level' with these params: target='${_target}', visibility='${_visibility}', language='${_language}'")

    target_compile_options(${_target}
                               ${_visibility}
                                   $<$<${_language}_COMPILER_ID:MSVC>:
                                       /W4>

                                   $<$<OR:$<${_language}_COMPILER_ID:GNU>,$<${_language}_COMPILER_ID:Clang>,$<${_language}_COMPILER_ID:AppleClang>>:
                                       -Wall
                                       -pedantic
                                       -Wno-long-long>)
endmacro()

macro(burda_cmake_helpers_cpp_warnings_suppress_cxx _target _warning _visibility)
    _burda_cmake_helpers_cpp_warnings_suppress(${_target} ${_warning} ${_visibility} CXX)
endmacro()

macro(burda_cmake_helpers_cpp_warnings_suppress_c _target _warning _visibility)
    _burda_cmake_helpers_cpp_warnings_suppress(${_target} ${_warning} ${_visibility} C)
endmacro()

# Supresses given compiler warning (e.g. when given "keyword-macro" it adds "-Wno-keyword-macro") to desired target
macro(_burda_cmake_helpers_cpp_warnings_suppress _target _warning _visibility _language)
    message(STATUS "Running 'burda_cmake_helpers_warnings_suppress' with these params: target='${_target}', warning='${_warning}', visibility='${_visibility}', language='${_language}'")

    target_compile_options(${_target}
                               ${_visibility}
                                   $<$<OR:$<${_language}_COMPILER_ID:GNU>,$<${_language}_COMPILER_ID:Clang>,$<${_language}_COMPILER_ID:AppleClang>>:
                                       -Wno-${_warning}>)
endmacro()
