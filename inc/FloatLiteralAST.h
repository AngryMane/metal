#ifndef FLOATLITERAL_H
#define FLOATLITERAL_H

#include "ASTCommon.h"
#include "ASTMacro.h"
#include "BaseAST.h"
#include "external.h"

class FloatLiteralAST : public BaseAST {

public: // initialize/filnalize

  // constructor
  FloatLiteralAST(
    float value)
    : BaseAST(AST_TYPE_FLOAT_LITERAL)
	 , m_Value(value){
     }

  // destructor
  virtual
  ~FloatLiteralAST(){
  }

public: // operation

  // generate
  virtual
  llvm::Value*
  GenerateValue(
    ParseContext& parse_context){
	  return llvm::ConstantInt::get(parse_context.m_Builder->getFloatTy(), m_Value);
  }

public: // operation

public: // query

private: // private methods

private: // private member vars

  // value
  MEMBER_WITH_GET(float, Value)

};

#endif
