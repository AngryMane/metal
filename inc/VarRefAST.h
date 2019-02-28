#ifndef VARREFAST_H
#define VARREFAST_H

#include "external.h"
#include "ASTCommon.h"
#include "BaseAST.h"

class VarRefAST : public BaseAST {

public: // initialize/filnalize

  // constructor
  VarRefAST(
    std::string name)
    : BaseAST(AST_TYPE_VAR_REF)
    , m_Name(name){
  }

  // destructor
  virtual
  ~VarRefAST(){
  }

public: // operation

  // generate
  virtual
  llvm::Value*
  GenerateValue(
    ParseContext& parse_context){
    auto* ret = parse_context.m_SymbolTableManager->Search(m_Name);
    return ret;
  }

public: // query

private: // private methods

private: // private member vars

  MEMBER_WITH_GET(std::string, Name)

};

#endif
