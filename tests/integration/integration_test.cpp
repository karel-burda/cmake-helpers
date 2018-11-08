#include <gtest/gtest.h>

#include "code_coverage_test.hpp"

namespace
{
TEST(dummy, compilation_test)
{
    burda::cmake::helpers::code_coverage_test coverage_coverage;
    coverage_coverage.make_foo();

    ASSERT_TRUE(true);
}
}
