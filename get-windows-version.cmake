# Sets the variable "WINDOWS_VERSION" with correct version of Windows OS
# Usage: get_windows_version()
function(get_windows_version)
    if (WIN32 AND CMAKE_SYSTEM_VERSION)
        set(WINDOWS_VERSION ${CMAKE_SYSTEM_VERSION})
        string(REPLACE "." "" WINDOWS_VERSION ${WINDOWS_VERSION})
        string(REGEX REPLACE "([0-9])" "0\\1" WINDOWS_VERSION ${WINDOWS_VERSION})
        set(WINDOWS_VERSION "0x${WINDOWS_VERSION}" PARENT_SCOPE)
    endif()
endfunction()
