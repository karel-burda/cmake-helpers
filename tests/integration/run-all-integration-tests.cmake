macro(_run_integration_test test_file)
    message(STATUS "Running integration test from ${test_file}")

    include(${test_file})

    message(STATUS "Done")
endmacro()

_run_integration_test("gtest.test.cmake")
