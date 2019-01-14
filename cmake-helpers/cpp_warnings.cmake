# Adds pedantic compiler warnings settings to given target
macro(burda_cmake_helpers_cpp_warnings_add_pedantic_level _target _visibility _language)
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

# Supresses given compiler warning (e.g. when given "keyword-macro" it adds "-Wno-keyword-macro") to desired target
macro(burda_cmake_helpers_cpp_warnings_suppress _target _warning _visibility _language)
    message(STATUS "Running 'burda_cmake_helpers_warnings_suppress' with these params: target='${_target}', warning='${_warning}', visibility='${_visibility}', language='${_language}'")

    if (NOT (CMAKE_C_COMPILER_ID MATCHES "GNU" AND NOT CMAKE_C_COMPILER_ID MATCHES "Clang") AND
        NOT (CMAKE_CXX_COMPILER_ID MATCHES "GNU" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang"))
        message(WARNING "Only GNU and Clang compilers are supported in this macro")
    endif()

    target_compile_options(${_target}
                               ${_visibility}
                                   $<$<OR:$<${_language}_COMPILER_ID:GNU>,$<${_language}_COMPILER_ID:Clang>,$<${_language}_COMPILER_ID:AppleClang>>:
                                       -Wno-${_warning}>)
endmacro()
