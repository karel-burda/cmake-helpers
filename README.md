![Version](https://img.shields.io/badge/version-0.1.0-green.svg)
[![License](https://img.shields.io/badge/license-MIT_License-green.svg?style=flat)](LICENSE)
[![Build Status](https://travis-ci.org/karel-burda/cmake-helpers.svg?branch=develop)](https://travis-ci.org/karel-burda/cmake-helpers)

# Introduction
`cmake-helpers` features tiny cmake-related functions and macros I'm using across my projects based on CMake.

See [cmake-helpers](cmake-helpers) for main functionality and [tests/unit](tests/unit) for unit tests.

# Build Process
The mentioned build process is just for development, the functionality might be, of course, used as a stand-alone.
Library itself is just header-only, so no need for additional linking, just threading library might need to be linked to the final executable on most Linux standard library implementations. See section [Usage](#Usage) for more info.

For generation of project containing the `cmake-heleprs` run the cmake in the top-level directory like this:

`cmake .`

I personally prefer to specify a separate build directory explicitly:

`cmake -Bbuild -H.`

You can of course specify ordinary cmake options like build type (debug, release with debug info, ...), used generator, etc.

# Unit Tests
For running the tests, execute

`cmake -P run-all-tests.cmake`

inside the [tests/unit](tests/unit).

For the time being, the tests are just sanity checks (using direct script execution), whether the functions and macros are "executable".
