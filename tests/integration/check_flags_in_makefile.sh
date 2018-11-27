#!/usr/bin/env bash

set -e

function check_flag_in_makefile
{
    local -r FLAG="$1"
    local -r MAKEFILE="$2/CMakeFiles/integration-tests.dir/flags.make"

    echo "Checking for flag '$FLAG' in the '$MAKEFILE'"

    grep -q "$FLAG" "$MAKEFILE"
}

readonly BINARY_DIR="$PWD"

check_flag_in_makefile "coverage" "$BINARY_DIR"
check_flag_in_makefile "pedantic" "$BINARY_DIR"

set +e
