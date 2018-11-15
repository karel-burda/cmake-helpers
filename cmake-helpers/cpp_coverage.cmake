# Adds code coverage compiler & linker flags, works on GNU toolchains
macro(burda_cmake_helpers_cpp_coverage_add_build_options _target _visibility)
    message(STATUS "Running 'burda_cmake_helpers_cpp_coverage_add_build_options' with these params: target='${_target}'")

    target_compile_options(
        ${_target}
            ${_visibility}
                $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:
                    --coverage>)

    target_links_options(
        ${_target}
            ${_visibility}
                $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:
                    --coverage>)
endmacro()
