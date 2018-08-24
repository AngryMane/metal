#ifndef BINARYOPERATORAST_H
#define BINARYOPERATORAST_H

#include "ASTCommon.h"
#include "ASTMacro.h"
#include "BaseAST.h"
#include "external.h"

class BinaryOperatorAST : public BaseAST {

public: 

  // TODO : Change Access Control to private
  // var type should be in private
  // operator type
  enum OPERATOR_TYPE{
    OPERATOR_TYPE_PLUS,
    OPERATOR_TYPE_MINUS,
    OPERATOR_TYPE_ASTER,
    OPERATOR_TYPE_SLASH,
    OPERATOR_TYPE_HAT,
    OPERATOR_TYPE_NUM,
  };

public: // initialize/filnalize

  // constructor
  BinaryOperatorAST(
    std::string op,
    BaseAST* lhs,
    BaseAST* rhs)
    : m_OperatorStr(op)
    , m_LeftOperand(lhs)
    , m_RightOperand(rhs)
    , BaseAST(AST_TYPE_BINARY_OPERATOR){
  }

  // destructor
  virtual
  ~BinaryOperatorAST(){
  }

public: // operation

public: // operation

public: // query

private: // private methods

private: // private member vars

  // operator string
  MEMBER_WITH_GET(std::string, OperatorStr)

  // Left Operand
  MEMBER_WITH_GET(BaseAST*, LeftOperand)

  // Right Operand
  MEMBER_WITH_GET(BaseAST*, RightOperand)

};

#endif
