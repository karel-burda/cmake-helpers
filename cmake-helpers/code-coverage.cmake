macro(_coverage_add_build_options _TARGET)
    if (CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        target_compile_options(
            ${_TARGET}
                PRIVATE
                    -fprofile-arcs
                    -ftest-coverage
                    -fcoverage-mapping
                    -fprofile-instr-generate)

        target_compile_options(
            ${_TARGET}
                PRIVATE $<$<CMAKE_CXX_COMPILER_ID:Clang>:
                    -fcoverage-mapping
                    -fprofile-instr-generate>)

        set_target_properties(
            ${_TARGET}
                PROPERTIES
                    LINK_FLAGS "-fprofile-arcs -ftest-coverage")
    endif()
endmacro()
