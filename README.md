![Version](https://img.shields.io/badge/version-1.3.1-blue.svg)
[![License](https://img.shields.io/badge/license-MIT_License-blue.svg?style=flat)](LICENSE)
[![Build Status](https://travis-ci.org/karel-burda/cmake-helpers.svg?branch=master)](https://travis-ci.org/karel-burda/cmake-helpers)
[![Codecov Status](https://codecov.io/gh/karel-burda/cmake-helpers/branch/develop/graph/badge.svg)](https://codecov.io/gh/karel-burda/cmake-helpers/branch/develop)

## Introduction
`cmake-helpers` features tiny cmake-related functions and macros I'm using across my projects based on CMake.

See [cmake-helpers](cmake-helpers) for main functionality and [tests](tests) for tests.

## Usage
All cmake functions are located in the [cmake-helpers](cmake-helpers).

## Examples
For full examples, see implementation of [tests](tests/integration).

### [cpp_gtest.cmake](cmake-helpers/cpp_gtest.cmake)
Test implemented at: [cpp_gtest_test.cmake](tests/integration/cpp_gtest_test.cmake)
```cmake
add_executable(my-tests)
target_sources(my-tests PRIVATE test.cpp)

include(cpp_gtest.cmake)
burda_cmake_helpers_cpp_gtest_bootstrap_and_link(my-tests release-1.8.1 Release PUBLIC)
```

### [cpp_coverage.cmake](cmake-helpers/cpp_coverage.cmake)
Test implemented at: [cpp_coverage_test.cmake](tests/integration/cpp_coverage_test.cmake)
```cmake
add_executable(my-tests)
target_sources(my-tests PRIVATE test.cpp)

include(cpp_coverage.cmake)
burda_cmake_helpers_cpp_coverage_add_build_options_cxx(my-tests PRIVATE)
# or for the C:
burda_cmake_helpers_cpp_coverage_add_build_options_c(my-tests PRIVATE)
```

### [cpp_warnings.cmake](cmake-helpers/cpp_warnings.cmake)
Test implemented at: [cpp_warnings_test.cmake](tests/integration/cpp_warnings_test.cmake)
```cmake
add_executable(my-project)
target_sources(my-project PRIVATE project.cpp)

include(cpp_warnings.cmake)
# For the C, replace "_cxx" with the "_c"
burda_cmake_helpers_cpp_warnings_add_pedantic_level_cxx(my-project PRIVATE)
burda_cmake_helpers_cpp_warnings_suppress_cxx(my-project some-specific-warning PRIVATE)
```

## Build Process
For generation of project containing the implementation and tests, run the cmake in the top-level directory like this:

`cmake .`

I personally prefer to specify a separate build directory explicitly:

`cmake -Bbuild -H.`

You can of course specify ordinary cmake options like build type (debug, release with debug info, ...), used generator, etc.

## Tests
For generation of integration tests (that is actually a full C++ project), execute (with example parameters) following:

```cmake
cmake -Bbuild/tests/integration -Htests/integration -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo

# on Unixes, this also checks the generated makefile for correct flags when used
# with the -G "Unix Makefiles"
cmake --build build/tests/integration --config RelWithDebInfo

# on Unixes you can also run target "check-coverage-files" after the binary was executed
# to inspect whether coverage files had been generated
./build/tests/integration
cmake --build build --config RelWithDebInfo --target check-coverage-files
```

Where `CMAKE_BUILD_TYPE` and `config` parameters are optional.

Tests are being run in the Continuous Integration environment on Linux, OS X and Windows.

Code coverage (in the non-optimized mode) is computed, see [.travis.yml](.travis.yml).

## Continuous Integration
Continuous Integration is now being run Linux, OS X and Windows on Travis: https://travis-ci.org/karel-burda/cmake-helpers.

The project is using these jobs:
  * `tests -- linux, debug, coverage, g++, 64-bit`
  * `tests -- osx, release with debug info, clang++, 64-bit`
  * `tests -- windows, release, msvc, 32-bit`
