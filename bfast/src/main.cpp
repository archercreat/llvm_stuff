#include "ir/ir.hpp"
#include "block.hpp"

int main()
{
    auto bb = ir::BasicBlock(0);
    auto x = std::make_shared<ir::Variable>();
    auto y = std::make_shared<ir::Variable>();
    auto z = std::make_shared<ir::Variable>();

    std::cout << z << "\n";
}
