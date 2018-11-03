![Version](https://img.shields.io/badge/version-1.0.0-green.svg)
[![License](https://img.shields.io/badge/license-MIT_License-green.svg?style=flat)](LICENSE)
[![Build Status](https://travis-ci.org/karel-burda/cmake-helpers.svg?branch=master)](https://travis-ci.org/karel-burda/cmake-helpers)

# Introduction
`cmake-helpers` features tiny cmake-related functions and macros I'm using across my projects based on CMake.

See [cmake-helpers](cmake-helpers) for main functionality and [tests](tests) for tests.

# Usage
All cmake functions are located in the [cmake-helpers](cmake-helpers).

## Examples
For full examples, see implementation of [tests](tests/integration).

### [gtest.cmake](cmake-helpers/gtest.cmake)
```cmake
add_executable("my-tests")
target_sources("my-tests" PRIVATE test.cpp)

include("${CMAKE_SOURCE_DIR}/cmake-helpers/gtest.cmake")
 _gtest_bootstrap_and_link("my-tests" "release-1.8.1" "Release")
```

### [coverage.cmake](cmake-helpers/coverage.cmake)
```cmake
add_executable("my-tests")
target_sources("my-tests" PRIVATE test.cpp)

include("${CMAKE_SOURCE_DIR}/cmake-helpers/coverage.cmake")
_coverage_add_build_options("my-tests")
```

### [warnings.cmake](cmake-helpers/warnings.cmake)
Only supports GNU compilers (e.g. GCC, Clang).
```cmake
add_executable("my-tests")
target_sources("my-tests" PRIVATE test.cpp)

include("${CMAKE_SOURCE_DIR}/cmake-helpers/warnings.cmake")
_warnings_add_pedantic_level(${PROJECT_NAME})
_warnings_suppress(${PROJECT_NAME} "some-specific-warning")
```

# Build Process
For generation of project containing the implementation and tests, run the cmake in the top-level directory like this:

`cmake .`

I personally prefer to specify a separate build directory explicitly:

`cmake -Bbuild -H.`

You can of course specify ordinary cmake options like build type (debug, release with debug info, ...), used generator, etc.

# Tests
For running integration tests, execute

`cmake  -Bbuild -H. -INTEGRATION-TESTS:BOOL=ON`

Tests are being run in the Continuous Integration environment.
