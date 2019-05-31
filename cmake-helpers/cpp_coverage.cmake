macro(burda_cmake_helpers_cpp_coverage_add_build_options_cxx _target _visibility _language)
    _burda_cmake_helpers_cpp_coverage_add_build_options(${_target} ${_visibility} CXX)
endmacro()

macro(burda_cmake_helpers_cpp_coverage_add_build_options_c _target _visibility _language)
    _burda_cmake_helpers_cpp_coverage_add_build_options(${_target} ${_visibility} C)
endmacro()

# Adds code coverage compiler & linker flags, works on GNU toolchains
macro(_burda_cmake_helpers_cpp_coverage_add_build_options _target _visibility _language)
    message(STATUS "Running 'burda_cmake_helpers_cpp_coverage_add_build_options' with these params: target='${_target}', visibility='${_visibility}', language='${_language}'")
    target_compile_options(${_target}
                               ${_visibility}
                                   $<$<OR:$<${_language}_COMPILER_ID:GNU>,$<${_language}_COMPILER_ID:Clang>,$<${_language}_COMPILER_ID:AppleClang>>:
                                       -fprofile-arcs
                                       -ftest-coverage>)

    # at this time, cannot use target_link_options, because it'll be introduced in CMake 3.13 (currently is beta),
    # not using set_target_properties(LINK_FLAGS), since the linker options would not be imported by oher targets,
    # thus using target_link_libraries (however, arguments have to be passed as a string and has to be one-liner)
    target_link_libraries(${_target}
                              ${_visibility}
                                  "$<$<OR:$<${_language}_COMPILER_ID:GNU>,$<${_language}_COMPILER_ID:Clang>,$<${_language}_COMPILER_ID:AppleClang>>:-fprofile-arcs -ftest-coverage>")
endmacro()
