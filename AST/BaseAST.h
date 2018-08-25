#ifndef BASEAST_H
#define BASEAST_H

#include "ASTCommon.h"
#include "ASTMacro.h"

class BaseAST {

public: // initialize/filnalize

  // constructor
  BaseAST(
    AST_TYPE type)
    : m_ASTType(type){
  }

  // destructor
  virtual
  ~BaseAST(){
  }

public: // operation

public: // query

  // get ast type
  AST_TYPE 
  GetType() const {
    return m_ASTType;
  }

  bool
  IsClassOf(
    BaseAST* ast) const {
    return (GetType() == ast->GetType())? (true) : (false);
  }

private: // private methods

private: // private member vars

  MEMBER_WITH_GET(AST_TYPE, ASTType)

};

#endif
