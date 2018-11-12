#!/usr/bin/env bash

set -e

function check_coverage_file
{
    local -r FILE="$1"

    echo "Checking coverage file '$FILE'"

    [ -f "$FILE" ];
}

function check_coverage_files
{
    local -r PATH="$1/CMakeFiles/integration-tests.dir/"
    echo "Checking coverage files from working directory '$PATH'"

    check_coverage_file "$PATH/integration_test.cpp.gcda"
    check_coverage_file "$PATH/integration_test.cpp.gcno"
}

readonly BINARY_DIR="$PWD"

check_coverage_files "$BINARY_DIR"

set +e
