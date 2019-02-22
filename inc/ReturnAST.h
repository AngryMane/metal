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
    : BaseAST(AST_TYPE_RETURN)
    , m_Ret(ret){
  }

  // destructor
  virtual
  ~ReturnAST(){
    delete m_Ret;
  }

public: // operation

  // generate
  virtual
  llvm::Value*
  GenerateValue(
    ParseContext& parse_context){
    return \
      (m_Ret == NULL)? (parse_context.m_Builder->CreateRetVoid()) : \
                       (parse_context.m_Builder->CreateRet(m_Ret->GenerateValue(parse_context)));
  }

public: // query

private: // private methods

private: // private member vars

  MEMBER_WITH_GET(BaseAST*, Ret)

};

#endif
