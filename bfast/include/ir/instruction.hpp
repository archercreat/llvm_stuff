#pragma once
#include <iostream>
#include <string>
#include <memory>

namespace ir
{
class Visitor;
class Expression;
using exprptr = std::shared_ptr<Expression>;

enum class InstructionType
{
    Assign = 0,
    Push,
    Pop,
};

class Instruction
{
protected:
    InstructionType type;
    Instruction(InstructionType type);

public:
    virtual ~Instruction() {}
    InstructionType getType() const;
    virtual void visit(Visitor&) = 0;
    virtual void toString(std::ostream& stream) const = 0;
};

using instrptr = std::shared_ptr<Instruction>;
std::ostream& operator<<(std::ostream& stream, const Instruction& expr);
std::ostream& operator<<(std::ostream& stream, const Instruction* expr);

class Assign : public Instruction
{
public:
    Assign(const exprptr& lhs, const exprptr& rhs);
    exprptr getLeft() const;
    exprptr getRight() const;
    void setLeft(exprptr expr);
    void setRight(exprptr expr);

    virtual void visit(Visitor&) override;
    virtual void toString(std::ostream& stream) const override;

private:
    exprptr lhs, rhs;
};

}; // namespace ir
