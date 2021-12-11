#include "ir/expression.hpp"

namespace ir
{
Expression::Expression(ExpressionType type) : type(type) {}

ExpressionType Expression::getType() const
{
    return this->type;
}

std::ostream& operator<<(std::ostream& stream, const Expression& expr)
{
    expr.toString(stream);
    return stream;
}

std::ostream& operator<<(std::ostream& stream, const Expression* expr)
{
    expr->toString(stream);
    return stream;
}

}; // namespace ir
