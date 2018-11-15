# Adds code coverage compiler & linker flags, works on GNU toolchains
macro(burda_cmake_helpers_cpp_coverage_add_build_options _target _visibility)
    message(STATUS "Running 'burda_cmake_helpers_cpp_coverage_add_build_options' with these params: target='${_target}'")

    target_compile_options(
        ${_target}
            ${_visibility}
                $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:
                    --coverage>)

    # At this time, cannot use target_link_options, because it'll be introduced in CMake 3.13 (currently is beta)
    # Not using set_target_properties(LINK_FLAGS), the linker options would not be imported by oher targets
    target_link_libraries(
        ${_target}
            ${_visibility}
                $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:
                    --coverage>)
endmacro()
