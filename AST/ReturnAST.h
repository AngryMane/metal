#ifndef RETURNAST_H
#define RETURNAST_H

#include "external.h"
#include "ASTCommon.h"
#include "BaseAST.h"

class ReturnAST : public BaseAST {

public: // initialize/filnalize

  // constructor
  ReturnAST(
    BaseAST* ret)
    : m_Ret(ret)
    , BaseAST(AST_TYPE_RETURN){
  }

  // destructor
  virtual
  ~ReturnAST(){
    delete m_Ret;
  }

public: // operation

public: // query

private: // private methods

private: // private member vars

  MEMBER_WITH_GET(BaseAST*, Ret)

};

#endif
