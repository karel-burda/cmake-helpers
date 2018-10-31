macro(_run_unit_test test_file)
    message(STATUS "Running unit test from ${test_file}")

    set(BASE_PATH "${CMAKE_SOURCE_DIR}/cmake-helpers")
    include(${test_file})

    message(STATUS "Done")
endmacro()

_run_unit_test("warnings.test.cmake")
