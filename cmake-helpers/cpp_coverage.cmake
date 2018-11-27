# Adds code coverage compiler & linker flags, works on GNU toolchains
macro(burda_cmake_helpers_cpp_coverage_add_build_options _target _visibility)
    message(STATUS "Running 'burda_cmake_helpers_cpp_coverage_add_build_options' with these params: target='${_target}'")

    target_compile_options(${_target}
                               ${_visibility}
                                   $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:
                                       -fprofile-arcs
                                       -ftest-coverage>)

    # At this time, cannot use target_link_options, because it'll be introduced in CMake 3.13 (currently is beta)
    # Not using set_target_properties(LINK_FLAGS), since the linker options would not be imported by oher targets,
    # thus using target_link_libraries (however, arguments have to be passed as a string)
    target_link_libraries(${_target}
                              ${_visibility}
                                  "$<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:-fprofile-arcs -ftest-coverage>")
endmacro()
