macro(_warnings_add_pedantic_level _target)
    target_compile_options(
        ${_target}
            PRIVATE
                $<$<CXX_COMPILER_ID:MSVC>:
                    /W4>

                $<$<CXX_COMPILER_ID:Clang|GNU>:
                    -Wall
                    -Werror
                    -pedantic
                    -Wno-long-long>)
endmacro()

macro(_warnings_supress _target _warning)

    target_compile_options
    if (NOT MSVC)
        target_compile_options(${_TARGET} PRIVATE -Wno-${_WARNING})
    endif()
endmacro()
