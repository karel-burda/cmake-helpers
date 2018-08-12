# This macro is meant to be executed only after target ${PROJECT_NAME} is created
macro(_link_threads_if_available _TARGET)
    find_package(Threads QUIET)

    if (CMAKE_THREAD_LIBS_INIT)
        _print_status_message("threading library found, going to link: ${CMAKE_THREAD_LIBS_INIT}")
        target_link_libraries(${_TARGET} PUBLIC ${CMAKE_THREAD_LIBS_INIT})
     endif()
endmacro()
