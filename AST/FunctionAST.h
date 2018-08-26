#ifndef FUNCTIONAST_H
#define FUNCTIONAST_H

#include "ASTCommon.h"
#include "ASTMacro.h"
#include "BaseAST.h"
#include "external.h"

class FunctionAST : public BaseAST {

public: // initialize/filnalize

  // constructor
  FunctionAST(
    std::string name,
    std::string type)
    : m_Name(name)
    , m_ValueType(type)
    , m_Args()
    , m_Statements()
    , BaseAST(AST_TYPE_FUNCTION){
  }

  // constructor
  FunctionAST(
    std::string name,
    std::string type,
    std::vector<BaseAST*> args)
    : m_Name(name)
    , m_ValueType(type)
    , m_Args(args)
    , m_Statements()
    , BaseAST(AST_TYPE_FUNCTION){
  }

  // destructor
  virtual
  ~FunctionAST(){
    for (auto cur : m_Args){
      delete cur;
    }

    for (auto cur : m_Statements){
      delete cur;
    }
  }

public: // operation

public: // operation

public: // query

private: // private methods

private: // private member vars

  MEMBER_WITH_GET(std::string, ValueType)

  MEMBER_WITH_GET(std::string, Name)

  MEMBER_WITH_GET(std::vector<BaseAST*>, Args)

  MEMBER_WITH_GET_SET(std::vector<BaseAST*>, Statements)

};

#endif
