#ifndef ASTCOMMON_H
#define ASTCOMMON_H

// AST type
enum AST_TYPE{
  AST_TYPE_BASE, // base ast
  AST_TYPE_INT_LITERAL, // int literal
  AST_TYPE_FLOAT_LITERAL, // float literal
  AST_TYPE_VAR_DECL, // var decl
  AST_TYPE_VAR_REF, // var reference
  AST_TYPE_BINARY_OPERATOR, // binary operator
  AST_TYPE_FUNC_CALL, // binary operator
  AST_TYPE_FUNCTION, // binary operator
  AST_TYPE_RETURN, // return
  AST_TYPE_NUM, // binary operator
  AST_TYPE_ROOT, // root(top of the tu) ast
  AST_TYPE_EXPRESSION, // expression ast
};

// Context struct
struct ParseContext{
	 ParseContext(
        llvm::LLVMContext* context,
        llvm::Module* module,
        llvm::IRBuilder<>* builder)
	     : m_Context(context)
	     , m_Module(module)
	     , m_Builder(builder){
	 }
    llvm::LLVMContext* m_Context;
    llvm::Module* m_Module;
    llvm::IRBuilder<>* m_Builder;
};

#endif
