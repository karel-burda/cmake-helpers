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

        void unused() {
            foo = false;
        }

    private:
        bool foo = false;
};
}
}
}