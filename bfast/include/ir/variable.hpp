#pragma once

namespace ir
{
class Visitor;
class Expression;

class Variable : public Expression
{
public:
    Variable(size_t size = 8);
    Variable(const std::string& name, size_t size = 8);
    std::string getName() const;
    virtual void visit(Visitor& visitor) override;
    virtual void toString(std::ostream& stream) const override;

private:
    static int index;
    std::string name;
    size_t size;
};

}; // namespace ir