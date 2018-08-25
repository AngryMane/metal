#ifndef INTLITERAL_H
#define INTLITERAL_H

#include "ASTCommon.h"
#include "ASTMacro.h"
#include "BaseAST.h"
#include "external.h"

class IntLiteralAST : public BaseAST {

public: // initialize/filnalize

  // constructor
  IntLiteralAST(
    int value)
    : m_Value(value)
    , BaseAST(AST_TYPE_INT_LITERAL){
  }

  // destructor
  virtual
  ~IntLiteralAST(){
  }

public: // operation

public: // operation

public: // query

private: // private methods

private: // private member vars

  // value
  MEMBER_WITH_GET(int, Value)

};

#endif
