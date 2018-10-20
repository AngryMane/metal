#ifndef FUNCCALLAST_H
#define FUNCCALLAST_H

#include "external.h"
#include "ASTMacro.h"
#include "BaseAST.h"

class FuncCallAST : public BaseAST {

public: 

public: // initialize/filnalize

  // constructor
  FuncCallAST(
    std::string func_name, 
    std::vector<BaseAST*> args)
    : BaseAST(AST_TYPE_FUNC_CALL)
    , m_FuncName(func_name)
    , m_FuncArgs(args){
  }

  // destructor
  virtual
  ~FuncCallAST(){
    for (auto cur : m_FuncArgs){
      delete cur;
    }
  }

public: // operation

public: // operation

public: // query

private: // private methods

private: // private member vars

  // function name
  MEMBER_WITH_GET(std::string, FuncName)

  // function args
  MEMBER_WITH_GET(std::vector<BaseAST*>, FuncArgs)

};

#endif
