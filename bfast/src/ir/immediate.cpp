#include "ir/expression.hpp"
#include "ir/immediate.hpp"

namespace ir
{

Immediate::Immediate(uint64_t value, size_t size) 
: Expression(ExpressionType::Immediate)
{
    this->value = value;
    this->size = size;
}

uint64_t Immediate::getValue() const
{
    return this->value;
}

void Immediate::visit(Visitor& visitor)
{
    visitor.visitImmediate(this);
}

void Immediate::toString(std::ostream& stream) const
{
    stream << std::hex << "0x" << this->value << std::dec;
}

}; // namespace ir
