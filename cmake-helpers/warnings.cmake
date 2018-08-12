macro(_add_pedantic_warning_level)
    set(CXX_WARNING_FLAGS "")

    if (MSVC)
        # "/Wall" Hardly usable on MSVC without excluding stdlib
        target_compile_options(${PROJECT_NAME} PUBLIC /W4)
    else()
        target_compile_options(${PROJECT_NAME} PUBLIC -Wall -Werror -pedantic -Wno-long-long)
    endif()
endmacro()

macro(_supress_cxx_compiler_warning _WARNING)
    if (NOT MSVC)
        target_compile_options(${PROJECT_NAME} PUBLIC -Wno-${_WARNING})
    endif()
endmacro()
