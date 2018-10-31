macro(_coverage_add_build_options _target)
    target_compile_options(
        ${_target}
            PRIVATE
                $<$<CXX_COMPILER_ID:GNU>:
                    -fprofile-arcs
                    -ftest-coverage>

                $<$<CXX_COMPILER_ID:Clang>:
                -fprofile-arcs
                -ftest-coverage
                -fcoverage-mapping
                -fprofile-instr-generate>)

    # Cannot use expression generator in set_target_properties()
    if (CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        set_target_properties(
            ${_target}
                PROPERTIES
                    LINK_FLAGS "-fprofile-arcs -ftest-coverage")
     endif()
endmacro()
