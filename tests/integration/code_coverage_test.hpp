#pragma once

namespace burda
{
namespace cmake
{
namespace helpers {
class code_coverage_test {
    public:
        void make_foo() {
            foo = true;
        }

    private:
        bool foo = false;
};
}
}
}