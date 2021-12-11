#include "ir/expression.hpp"
#include "ir/binary.hpp"

namespace ir
{

BinaryOperation::BinaryOperation(const exprptr& lhs, const exprptr& rhs, BinaryType type) 
: Expression(ExpressionType::Binary)
{
    this->lhs = lhs;
    this->rhs = rhs;
    this->type = type;
}

exprptr BinaryOperation::getLeft() const
{
    return this->lhs;
}

exprptr BinaryOperation::getRight() const
{
    return this->rhs;
}

void BinaryOperation::setLeft(exprptr expr)
{
    this->lhs = expr;
}

void BinaryOperation::setRight(exprptr expr)
{
    this->rhs = expr;
}

Add::Add(const exprptr& lhs, const exprptr& rhs) : BinaryOperation(lhs, rhs, BinaryType::Add) {}

void Add::visit(Visitor& visitor)
{
    visitor.visitAddNode(this);
}

void Add::toString(std::ostream& stream) const
{
    stream << "Add(" << this->lhs << ", " << this->rhs << ")";
}

}; // namespace ir
