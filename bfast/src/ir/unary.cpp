#include "ir/expression.hpp"
#include "ir/unary.hpp"

namespace ir
{
UnaryOperation::UnaryOperation(const exprptr& expr, UnaryType type) 
: Expression(ExpressionType::Unary)
{
    this->expr = expr;
    this->type = type;
}

exprptr UnaryOperation::getExpr() const
{
    return this->expr;
}

void UnaryOperation::setExpr(exprptr expr)
{
    this->expr = expr;
}

// Unary Inc definition
Inc::Inc(const exprptr& expr) : UnaryOperation(expr, UnaryType::Inc) {}

void Inc::visit(Visitor& visitor)
{
    visitor.visitIncNode(this);
}

void Inc::toString(std::ostream& stream) const
{
    stream << "Inc(" << this->expr << ")";
}
}; // namespace ir
