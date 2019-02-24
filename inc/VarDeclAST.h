#ifndef VARAST_H
#define VARAST_H

#include "external.h"
#include "ASTMacro.h"
#include "BaseAST.h"

class VarDeclAST : public BaseAST {

public: 

  // TODO : Change Access Control to private
  // var type should be in private
  // var type
  enum VAR_TYPE{
    VAR_TYPE_LOCAL,
    VAR_TYPE_ARG,
    VAR_TYPE_NUM,
  };

public: // initialize/filnalize

  // constructor
  VarDeclAST(
    std::string name,
    VAR_TYPE type)
    : BaseAST(AST_TYPE_VAR_DECL)
    , m_Name(name)
    , m_Value(0)
    , m_VarType(type){
  }

  // destructor
  virtual
  ~VarDeclAST(){
  }

public: // operation

  // generate
  virtual
  llvm::Value*
  GenerateValue(
    ParseContext& parse_context){
    auto var = parse_context.m_Builder->CreateAlloca(parse_context.m_Builder->getInt64Ty(), nullptr, m_Name.c_str());
    parse_context.m_SymbolTableManager->AddSymbol(m_Name, var);
    return var;
  }

public: // query

private: // private methods

private: // private member vars

  // var name
  MEMBER_WITH_GET_SET(std::string, Name)

  // var value
  MEMBER_WITH_GET_SET(int, Value)

  // var type
  MEMBER_WITH_GET(VAR_TYPE, VarType)

};

#endif
