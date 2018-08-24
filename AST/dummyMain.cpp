#include "VarDeclAST.h"
#include "BinaryOperatorAST.h"
#include "FuncCallAST.h"
#include "external.h"

int
main(){

  VarDeclAST var_decl = VarDeclAST("test1", VarDeclAST::VAR_TYPE_LOCAL);
  auto ret = var_decl.IsClassOf(&var_decl);
  std::cout << var_decl.GetName() << std::endl;
  std::cout << ret << std::endl;

  BinaryOperatorAST bibary_op = BinaryOperatorAST("+", NULL, NULL);
  std::cout << bibary_op.GetOperatorStr() << std::endl;


  std::vector<BaseAST*> args;
  FuncCallAST func_call = FuncCallAST("func_name", args);
  std::cout << func_call.GetFuncName() << std::endl;

  return 0;
}
