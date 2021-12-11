#pragma once
#include "visitors/visitor.hpp"

#include <iostream>
#include <string_view>
#include <memory>

namespace ir
{
enum class ExpressionType
{
    Register = 0,
    Memory,
    Variable,
    Immediate,
    Unary,
    Binary
};

class Expression
{
protected:
    ExpressionType type;
    Expression(ExpressionType type);

public:
    virtual ~Expression() {}
    ExpressionType getType() const;
    virtual void visit(Visitor&) = 0;
    virtual void toString(std::ostream& stream) const = 0;
};

using exprptr = std::shared_ptr<Expression>;

std::ostream& operator<<(std::ostream& stream, const Expression& expr);
std::ostream& operator<<(std::ostream& stream, const Expression* expr);
};