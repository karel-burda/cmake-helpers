macro(_run_unit_test test_file)
    message(STATUS "Running unit test from ${test_file}")

    #EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -DBASE_PATH:STRING=../../cmake-helpers -P ${test_file})
    set(BASE_PATH "${CMAKE_SOURCE_DIR}/cmake-helpers")
    include(${test_file})

    message(STATUS "Done")
endmacro()

_run_unit_test("messages.test.cmake")
_run_unit_test("source-group-by-folder.test.cmake")
_run_unit_test("standard-settings.test.cmake")
_run_unit_test("warnings.test.cmake")
