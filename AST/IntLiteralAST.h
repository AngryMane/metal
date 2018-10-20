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
    : BaseAST(AST_TYPE_INT_LITERAL)
	 , m_Value(value){
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
