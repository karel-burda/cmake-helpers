include("${CMAKE_SOURCE_DIR}/cmake-helpers/get-windows-version.cmake")

_get_windows_version()

if(WIN32)
    if (NOT DEFINED _WINDOWS_VERSION)
        message(FATAL_ERROR "_WINDOWS_VERSION variables is not defined")
    endif()
endif()
