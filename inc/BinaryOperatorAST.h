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
    : BaseAST(AST_TYPE_BINARY_OPERATOR)
    , m_OperatorType(OPERATOR_TYPE_PLUS)
    , m_LeftOperand(lhs)
    , m_RightOperand(rhs){
	auto itr = OPERATOR_CONVERTOR.find(op);
    m_OperatorType = (itr == OPERATOR_CONVERTOR.end())? (OPERATOR_TYPE_UNKNOWN) : (itr->second);
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
    ParseContext& parse_context){

	 typedef std::function<llvm::Value*(llvm::Value *LHS, llvm::Value *RHS)> GENERATOR_FUNCTION;
	 GENERATOR_FUNCTION add = std::bind(&llvm::IRBuilder<>::CreateAdd, parse_context.m_Builder, std::placeholders::_1, std::placeholders::_2, "", false, false);
	 GENERATOR_FUNCTION sub = std::bind(&llvm::IRBuilder<>::CreateAdd, parse_context.m_Builder, std::placeholders::_1, std::placeholders::_2, "", false, false);
	 GENERATOR_FUNCTION mul = std::bind(&llvm::IRBuilder<>::CreateAdd, parse_context.m_Builder, std::placeholders::_1, std::placeholders::_2, "", false, false);
	 GENERATOR_FUNCTION div = std::bind(&llvm::IRBuilder<>::CreateAdd, parse_context.m_Builder, std::placeholders::_1, std::placeholders::_2, "", false, false);
	 GENERATOR_FUNCTION hat = std::bind(&llvm::IRBuilder<>::CreateAdd, parse_context.m_Builder, std::placeholders::_1, std::placeholders::_2, "", false, false);
	 GENERATOR_FUNCTION generator =
			 (OPERATOR_TYPE_PLUS == m_OperatorType) ? (add) :
			 (OPERATOR_TYPE_MINUS == m_OperatorType) ? (sub) :
			 (OPERATOR_TYPE_ASTER == m_OperatorType) ? (mul) :
			 (OPERATOR_TYPE_SLASH == m_OperatorType) ? (div) :
			 (OPERATOR_TYPE_HAT == m_OperatorType) ? (hat) :
			 (0);

    //llvm::Value* result = parse_context.m_Builder->CreateAlloca(parse_context.m_Builder->getInt64Ty());
    //auto* keisan = generator(m_LeftOperand->GenerateValue(parse_context), m_RightOperand->GenerateValue(parse_context));
    //auto* ret = parse_context.m_Builder->CreateStore(keisan, result);

    //return parse_context.m_Builder->CreateLoad(result);
    return generator(m_LeftOperand->GenerateValue(parse_context), m_RightOperand->GenerateValue(parse_context));
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
