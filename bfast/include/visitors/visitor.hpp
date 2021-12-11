#pragma once

namespace ir
{

class Expression;
class Immediate;
class Variable;

class Inc;

class Add;
class Assign;

class Visitor
{
public:
    virtual void visitImmediate(Immediate*);
    virtual void visitVariable(Variable*);

    virtual void visitIncNode(Inc*);

    virtual void visitAddNode(Add*);
    virtual void visitAssignNode(Assign*);
};

}; // namespace ir
