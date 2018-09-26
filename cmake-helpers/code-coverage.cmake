macro(_coverage_add_build_options _TARGET)
    target_compile_options(
        ${_TARGET}
            PRIVATE $<$<CXX_COMPILER_ID:GNU>:
                -fprofile-arcs
                -ftest-coverage>)

    target_compile_options(
        ${_TARGET}
            PRIVATE $<$<CXX_COMPILER_ID:Clang>:
                -fprofile-arcs
                -ftest-coverage
                -fcoverage-mapping
                -fprofile-instr-generate>)

    # Cannot use expression generator in set_target_properties()
    if (CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        set_target_properties(
            ${_TARGET}
                PROPERTIES
                    LINK_FLAGS "-fprofile-arcs -ftest-coverage")
     endif()
endmacro()
