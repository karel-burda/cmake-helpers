# Example: _set_standards(11 14)
macro(_set_standards C_STANDARD CXX_STANDARD)
    set(CMAKE_C_STANDARD ${C_STANDARD})
    set(CMAKE_C_STANDARD_REQUIRED ON)
    set(CMAKE_CXX_STANDARD ${CXX_STANDARD})
   set(CMAKE_CXX_STANDARD_REQUIRED ON)
endmacro()

macro(_set_default_build_type BUILD_TYPE)
    if (NOT DEFINED CMAKE_BUILD_TYPE)
        _print_status_message("CMAKE_BUILD_TYPE undefined, setting it to ${BUILD_TYPE}")
        set(CMAKE_BUILD_TYPE ${BUILD_TYPE})
    endif()
endmacro()

# This is recommended as well:
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
#set_property(GLOBAL PROPERTY USE_FOLDERS ON)
