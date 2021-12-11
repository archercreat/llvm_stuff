#include "ir/expression.hpp"
#include "ir/instruction.hpp"

namespace ir
{

Instruction::Instruction(InstructionType type) : type(type) {}

InstructionType Instruction::getType() const
{
    return this->type;
}

Assign::Assign(const exprptr& lhs, const exprptr& rhs) : Instruction(InstructionType::Assign) 
{
    this->lhs = lhs;
    this->rhs = rhs;
}

exprptr Assign::getLeft() const
{
    return this->lhs;
}

exprptr Assign::getRight() const
{
    return this->rhs;
}

void Assign::setLeft(exprptr expr)
{
    this->lhs = expr;
}

void Assign::setRight(exprptr expr)
{
    this->rhs = expr;
}

void Assign::visit(Visitor& visitor)
{
    visitor.visitAssignNode(this);
}

void Assign::toString(std::ostream& stream) const
{
    stream << "Assign(" << this->lhs << ", " << this->rhs << ")";
}

}; // namespace ir
