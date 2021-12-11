#pragma once

namespace ir
{
class Visitor;
class Expression;
using exprptr = std::shared_ptr<Expression>;

enum class BinaryType
{
    Invalid = -1,
    Add,
    Sub,
    Imul,
    Shl,
    Shr,
    Rcr,
    Rcl,
    Rol,
    Ror,
    And,
    Or,
    Xor,
    Cmp,
};

class BinaryOperation : public Expression
{
protected:
    BinaryOperation(const exprptr& lhs, const exprptr& rhs, BinaryType type);
    exprptr lhs, rhs;
    BinaryType type;

public:
    exprptr getLeft() const;
    exprptr getRight() const;
    void setLeft(exprptr expr);
    void setRight(exprptr expr);
};

class Add : public BinaryOperation
{
public:
    Add(const exprptr& lhs, const exprptr& rhs);
    virtual void visit(Visitor& visitor) override;
    virtual void toString(std::ostream& stream) const override;
};
    
}; // namespace ir