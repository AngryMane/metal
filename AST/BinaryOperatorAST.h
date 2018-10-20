#ifndef BINARYOPERATORAST_H
#define BINARYOPERATORAST_H

#include "ASTCommon.h"
#include "ASTMacro.h"
#include "BaseAST.h"
#include "ExpressionAST.h"
#include "external.h"

class BinaryOperatorAST : public BaseAST {

private:

  // operator type
  enum OPERATOR_TYPE{
    OPERATOR_TYPE_PLUS,
    OPERATOR_TYPE_MINUS,
    OPERATOR_TYPE_ASTER,
    OPERATOR_TYPE_SLASH,
    OPERATOR_TYPE_HAT,
    OPERATOR_TYPE_UNKNOWN,
    OPERATOR_TYPE_NUM,
  };

  const std::map<std::string, OPERATOR_TYPE> OPERATOR_CONVERTOR = {
		  {"+", OPERATOR_TYPE_PLUS},
		  {"-", OPERATOR_TYPE_MINUS},
		  {"*", OPERATOR_TYPE_ASTER},
		  {"/", OPERATOR_TYPE_SLASH},
		  {"^", OPERATOR_TYPE_HAT},
  };

public: // initialize/filnalize

  // constructor
  BinaryOperatorAST(
    std::string op,
    ExpressionAST* lhs,
    ExpressionAST* rhs)
    : m_OperatorType(OPERATOR_TYPE_PLUS)
    , m_LeftOperand(lhs)
    , m_RightOperand(rhs)
    , BaseAST(AST_TYPE_BINARY_OPERATOR){
	auto itr = OPERATOR_CONVERTOR.find(op);
    m_OperatorType = (itr == OPERATOR_CONVERTOR.end())? (OPERATOR_TYPE_UNKNOWN) : (*itr);
  }

  // destructor
  virtual
  ~BinaryOperatorAST(){
    delete m_LeftOperand;
    delete m_RightOperand;
  }

public: // operation

  // generate
  virtual
  llvm::Value*
  GenerateValue(
    llvm::LLVMContext& context,
    llvm::Module* module,
    llvm::IRBuilder<> builder){
	 llvm::Value*  ret = NULL;
	  switch(m_OperatorType){
      OPERATOR_TYPE_PLUS:
	  ret = builder.CreateAdd(
			  m_LeftOperand->GenerateValue(context, module, builder),
			  m_RightOperand->GenerateValue(context, module, builder));
		break;
      OPERATOR_TYPE_MINUS:
	  ret = builder.CreateSub(
			  m_LeftOperand->GenerateValue(context, module, builder),
			  m_RightOperand->GenerateValue(context, module, builder));
		break;
      OPERATOR_TYPE_ASTER:
	  ret = builder.CreateMul(
			  m_LeftOperand->GenerateValue(context, module, builder),
			  m_RightOperand->GenerateValue(context, module, builder));
		break;
      OPERATOR_TYPE_SLASH:
	  ret = builder.CreateUDiv(
			  m_LeftOperand->GenerateValue(context, module, builder),
			  m_RightOperand->GenerateValue(context, module, builder));
		break;
      OPERATOR_TYPE_HAT:
	    // TODO
		break;
      OPERATOR_TYPE_UNKNOWN:
	   fprintf(stderr, "[error]unknown operator\n");
		break;
	  }
	  return ret;
  }

public: // operation

public: // query

private: // private methods

private: // private member vars

  // operator string
  MEMBER_WITH_GET(OPERATOR_TYPE, OperatorType)

  // Left Operand
  MEMBER_WITH_GET(ExpressionAST*, LeftOperand)

  // Right Operand
  MEMBER_WITH_GET(ExpressionAST*, RightOperand)

};

#endif
