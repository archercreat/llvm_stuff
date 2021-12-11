#pragma once

namespace ir
{
class Visitor;
class Expression;
using exprptr = std::shared_ptr<Expression>;

enum class UnaryType
{
    invalid = -1,
    Inc,
    Dec,
    Not,
    Neg,
    Extend,
    Signextend,
    Zeroextend,
    Extract,
    Flagsof,
};

class UnaryOperation : public Expression
{
protected:
    UnaryOperation(const exprptr& expr, UnaryType type);
    exprptr expr;
    UnaryType type;

public:
    exprptr getExpr() const;
    void setExpr(exprptr expr);
};

class Inc : public UnaryOperation
{
public:
    Inc(const exprptr& expr);
    virtual void visit(Visitor& visitor) override;
    virtual void toString(std::ostream& stream) const override;
};

}; // namespace ir