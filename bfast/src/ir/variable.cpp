#include "ir/expression.hpp"
#include "ir/variable.hpp"

namespace ir
{
int Variable::index = 0;

Variable::Variable(size_t size) : Expression(ExpressionType::Variable)
{
    this->name = "t" + std::to_string(++index);
    this->size = size;
}

Variable::Variable(const std::string& name, size_t size) 
: Expression(ExpressionType::Variable)
{
    this->name = name;
    this->size = size;
}

std::string Variable::getName() const
{
    return this->name;
}

void Variable::visit(Visitor& visitor)
{
    visitor.visitVariable(this);
}

void Variable::toString(std::ostream& stream) const
{
    stream << this->name;
}

}; // namespace ir
