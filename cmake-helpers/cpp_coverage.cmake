macro(burda_cmake_helpers_cpp_coverage_add_build_options _target _visibility)
    message(STATUS "Running 'burda_cmake_helpers_cpp_coverage_add_build_options' with these params: target='${_target}'")

    target_compile_options(
        ${_target}
            ${_visibility}
                $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:
                    -fprofile-arcs
                    -ftest-coverage>

                $<$<OR:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:
                    -fcoverage-mapping
                    -fprofile-instr-generate>)

    if (CMAKE_CXX_COMPILER_ID MATCHES "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        set_target_properties(
            ${_target}
                PROPERTIES
                    LINK_FLAGS "-fprofile-arcs -ftest-coverage")
    endif()
endmacro()
