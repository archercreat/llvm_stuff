#include <vector>
#include <memory>

namespace ir
{
class Instruction;
using instrptr = std::shared_ptr<Instruction>;

class BasicBlock
{
public:
    BasicBlock(unsigned long long address);
    
private:
    unsigned long long address;
    std::vector<Instruction> instructions;
    std::shared_ptr<BasicBlock> nextBlock, targetBlock;
};

}; // namespace ir