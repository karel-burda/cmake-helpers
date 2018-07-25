macro(_run_test test_file)
    message(STATUS "Running test from ${test_file}")
    EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -DBASE_PATH:STRING=../../cmake-helpers -P ${test_file})
endmacro()


_run_test("get-windows-version.test.cmake")
_run_test("messages.test.cmake")
