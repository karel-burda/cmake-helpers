macro(_run_test test_file)
    message(STATUS "Running test from ${test_file}")

    EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -DBASE_PATH:STRING=../../cmake-helpers -P ${test_file})

    message(STATUS "Done")
endmacro()

_run_test("messages.test.cmake")
_run_test("standard-settings.test.cmake")
_run_test("warnings.test.cmake")
