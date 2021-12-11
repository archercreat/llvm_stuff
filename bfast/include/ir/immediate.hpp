#pragma once

namespace ir
{
class Visitor;
class Expression;
using exprptr = std::shared_ptr<Expression>;

class Immediate : public Expression
{
public:
    Immediate(uint64_t value, size_t size = 8);
    uint64_t getValue() const;
    virtual void visit(Visitor& visitor) override;
    virtual void toString(std::ostream& stream) const override;

private:
    size_t size;
    uint64_t value;
};

}; // namespace ir
