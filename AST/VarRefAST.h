#ifndef VARREFAST_H
#define VARREFAST_H

#include "external.h"
#include "BaseAST.h"

class VarRefAST : public BaseAST {

public: // initialize/filnalize

  // constructor
  VarRefAST(
    std::string name)
    : m_Name(name)
    , BaseAST(AST_TYPE_VAR_REF){
  }

  // destructor
  virtual
  ~VarRefAST(){
  }

public: // operation

public: // query

private: // private methods

private: // private member vars

  MEMBER_WITH_GET(std::string, Name)

};

#endif
