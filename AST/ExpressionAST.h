#ifndef EXPRESSIONAST_H
#define EXPRESSIONAST_H

#include "ASTCommon.h"
#include "BaseAST.h"

class ExpressionAST : public BaseAST {
public: // initialize/filnalize

  // constructor
  ExpressionAST(
	 BaseAST* value)
    : BaseAST(AST_TYPE_EXPRESSION)
	 , m_Value(value){
  }

  // destructor
  virtual
  ~ExpressionAST(){
	  delete m_Value;
  }

public: // operation

  // generate
  virtual
  llvm::Value*
  GenerateValue(
    llvm::LLVMContext& context,
    llvm::Module* module,
    llvm::IRBuilder<> builder){
	  return m_Value->GenerateValue(context, module, builder);
  }

public: // query

private: // private methods

private: // private member vars

  // Literal expression
  BaseAST* m_Value;

};

#endif
