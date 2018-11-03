macro(_warnings_add_pedantic_level _target)
    message(STATUS "Running '_warnings_add_pedantic_level' with these params: target='${_target}'")

    target_compile_options(
        ${_target}
            PRIVATE
                $<$<CXX_COMPILER_ID:MSVC>:
                    /W4>

                $<$<CXX_COMPILER_ID:GNU>:
                    -Wall
                    -Werror
                    -pedantic
                    -Wno-long-long>)
endmacro()

macro(_warnings_supress _target _warning)
    message(STATUS "Running '_warnings_supress' with these params: target='${_target}', warning='${_warning}'")

    target_compile_options(${_target} PRIVATE $<$<CXX_COMPILER_ID:GNU>:-Wno-${_WARNING}>)
endmacro()
