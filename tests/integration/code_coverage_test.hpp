#pragma once

namespace burda
{
namespace cmake
{
namespace helpers
{
class code_coverage_test
{
public:
    void make_foo(const bool should_call_unused)
    {
        foo = true;

        if (should_call_unused)
        {
            unused();
        }
    }

    void unused()
    {
        foo = false;
    }

private:
    bool foo = false;
};
}
}
}
