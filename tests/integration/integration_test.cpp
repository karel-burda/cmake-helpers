#include <gtest/gtest.h>

#include "code_coverage_test.hpp"

namespace
{
TEST(dummy, compilation_test)
{
    burda::cmake::helpers::code_coverage_test coverage_coverage;

    // deliberately multiple times to inspect coverage reports
    coverage_coverage.make_foo(false);
    coverage_coverage.make_foo(false);
    coverage_coverage.make_foo(false);

    ASSERT_TRUE(true);
}
}
