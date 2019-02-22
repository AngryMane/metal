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
    : BaseAST(AST_TYPE_FUNCTION)
    , m_ValueType(type)
    , m_Name(name)
    , m_Args()
    , m_Statements(){
  }

  // constructor
  FunctionAST(
    std::string name,
    std::string type,
    std::vector<BaseAST*> args)
    : BaseAST(AST_TYPE_FUNCTION)
    , m_ValueType(type)
    , m_Name(name)
    , m_Args(args)
    , m_Statements(NULL){
  }

  // destructor
  virtual
  ~FunctionAST(){
    for (auto cur : m_Args){
      delete cur;
    }

    for (auto cur : *m_Statements){
      delete cur;
    }
    delete m_Statements;
  }

public: // operation

  // generate
  virtual
  llvm::Value*
  GenerateValue(
    ParseContext& parse_context){
    auto *funcType = llvm::FunctionType::get(parse_context.m_Builder->getVoidTy(), false);
    auto *mainFunc = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, m_Name, parse_context.m_Module);
    auto *entrypoint = llvm::BasicBlock::Create(*parse_context.m_Context, "entry-point", mainFunc);
    parse_context.m_Builder->SetInsertPoint(entrypoint);

    std::reverse(m_Statements->begin(), m_Statements->end());
    for (auto cur : *m_Statements){
      cur->GenerateValue(parse_context);
    }
  }

public: // operation

public: // query

private: // private methods

private: // private member vars

  MEMBER_WITH_GET(std::string, ValueType)

  MEMBER_WITH_GET(std::string, Name)

  MEMBER_WITH_GET(std::vector<BaseAST*>, Args)

  MEMBER_WITH_GET_SET(std::vector<BaseAST*>*, Statements)

};

#endif
