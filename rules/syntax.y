/*
 *          Bisonによる簡単な表現式パーサ
 */

%code requires{

#include "external.h"
#include "BaseAST.h"
#include "ExpressionAST.h"
#include "IntLiteralAST.h"
#include "VarDeclAST.h"
#include "VarRefAST.h"
#include "FuncCallAST.h"
#include "ReturnAST.h"
#include "FunctionAST.h"
#include "RootAST.h"

}

%{

#include "external.h"
#include "FlexLexer.h"

// Bisonで生成するコードが参照する関数
// 定義がライブラリ(libfl.a)内に存在する
// ライブラリをリンクしたくないため、自分で定義する。
void yyerror(llvm::LLVMContext& context, llvm::Module* module, llvm::IRBuilder<>& builder, const char *s);

// Bisonで生成するコードが参照する関数
// Flex++はyyFlexLexer::yylex()になるため、ラッパを自前で定義する
int yylex(void);

// flexのインスタンス
yyFlexLexer* lexer;

%}

%union {
  char m_string[128];
  int m_int;
  bool m_bool;
  BaseAST* m_BaseAST;
  ExpressionAST* m_ExpressionAST;
  IntLiteralAST* m_IntLiteralAST;
  std::vector<BaseAST*>* m_BaseASTContainer;
}

%parse-param      {llvm::LLVMContext& context}
%parse-param      {llvm::Module* module}
%parse-param      {llvm::IRBuilder<>& builder}

%token SYMBOL
%token SEMICOLON
%token TEXT
%token INT_VAL
%token BOOL_VAL
%token BRACKET_S
%token BRACKET_E
%token COLON
%token BRACE_S
%token BRACE_E
%token DEF
%token COMMA
%token PLUS
%token MINUS
%token ASTER
%token SLASH
%token EQUAL
%token VAR_INIT_DEF
%token PROJECTION_ARROW
%token PARENTHESE_S
%token PARENTHESE_E
%token RETURN
%token INT_TYPE
%token VOID_TYPE

%type <m_string> SYMBOL SEMICOLON TEXT BRACKET_S BRACKET_E COLON BRACE_S BRACE_E DEF COMMA PLUS MINUS ASTER SLASH EQUAL VAR_INIT_DEF 
%type <m_string> PROJECTION_ARROW PARENTHESE_S PARENTHESE_E RETURN INT_TYPE VOID_TYPE primary_type 
%type <m_int> INT_VAL
%type <m_bool> BOOL_VAL

// expression
%type <m_ExpressionAST> expression 
%type <m_IntLiteralAST> int_literal 

// statement
%type <m_BaseAST> statement var_decl return projection_info function_decl external_decl  root

%type <m_BaseASTContainer> var_decls statements function_body 

// priority and associativity of operator
%left PLUS MINUS
%left ASTER SLASH

%%

//--------------------------------------------------------
// global syntax 

root       :                    {$$ = new RootAST();}
           | external_decl root {$$ = $2;dynamic_cast<RootAST*>($$)->AddDecl($1);}
           ;

external_decl : function_decl  {$$ = $1;}
              | statement {$$ = $1;}
              ;

function_decl : projection_info function_body {$$ = $1;dynamic_cast<FunctionAST*>($$)->SetStatements(*$2);}
              ;

projection_info : DEF SYMBOL COLON PROJECTION_ARROW primary_type           {$$ = new FunctionAST($2, $5);}
                | DEF SYMBOL COLON var_decls PROJECTION_ARROW primary_type {$$ = new FunctionAST($2, $6, *$4);}
                ;

function_body : BRACE_S statements BRACE_E {$$ = $2;}
              ;

//--------------------------------------------------------
// primary type

primary_type : INT_TYPE
             | VOID_TYPE
             ;

//--------------------------------------------------------
// statement

statements :                      {$$ = new std::vector<BaseAST*>;}
           | statement statements {$$ = $2;$2->push_back($1);}
           ;

statement : var_decl SEMICOLON   {$$ = $1;}
          | return SEMICOLON     {$$ = $1;}
          | expression SEMICOLON {$$ = $1;}
          ;

var_decl  : primary_type SYMBOL                         {$$ = new VarDeclAST($2, VarDeclAST::VAR_TYPE::VAR_TYPE_LOCAL);}
          | primary_type SYMBOL VAR_INIT_DEF expression {$$ = new VarDeclAST($2, VarDeclAST::VAR_TYPE::VAR_TYPE_LOCAL);}
          ;

return  : RETURN expression {$$ = new ReturnAST($2);}
        ;

//--------------------------------------------------------
// expression

expression : expression PLUS expression {$$ = NULL;std::cout << "PLUS" << std::endl;}
           | expression MINUS expression {$$ = NULL;std::cout << "MINUS" << std::endl;}  
           | expression ASTER expression {$$ = NULL;std::cout << "ASTER" << std::endl;}
           | expression SLASH expression {$$ = NULL;std::cout << "SLASH" << std::endl;}
           | PARENTHESE_S expression PLUS expression PARENTHESE_E {$$ = NULL;std::cout << "(PLUS)" << std::endl;}
           | PARENTHESE_S expression MINUS expression PARENTHESE_E {$$ = NULL;std::cout << "(MINUS)" << std::endl;}
           | PARENTHESE_S expression ASTER expression PARENTHESE_E {$$ = NULL;std::cout << "(ASTER)" << std::endl;}
           | PARENTHESE_S expression SLASH expression PARENTHESE_E {$$ = NULL;std::cout << "(SLASH)" << std::endl;}
           | int_literal {$$ = new ExpressionAST($1);}
             ;
             
int_literal : INT_VAL {$$ = new IntLiteralAST($1);}
              ;

//--------------------------------------------------------
// other

var_decls : var_decl                 {$$ = new std::vector<BaseAST*>;$$->push_back($1);}
          | var_decl COMMA var_decls {$$ = $3;$$->push_back($1);}
          ;

//--------------------------------------------------------


%%

void yyerror(llvm::LLVMContext& context, llvm::Module* module, llvm::IRBuilder<>& builder, const char *s){
  std::cout << "Syntax error" << std::endl;
  std::cout << "Reduction failed in:" << std::endl;
  std::cout << "Line :" << lexer->lineno() << std::endl;
  std::cout << "Token:" << lexer->YYText() << std::endl;
}

int yylex(void){
  return lexer->yylex();
}

int main(){
  std::filebuf file;
  bool ret = file.open("./result/target.cpp", std::ios::in);
  if (ret == false){
    std::cout << "Open target file failed" << std::endl;
    return 1;
  }

  std::istream ifs(&file);
  lexer = new yyFlexLexer(&ifs);
  llvm::LLVMContext context;
  llvm::Module *module = new llvm::Module("top", context);
  llvm::IRBuilder<> builder(context);
  yyparse(context, module, builder);
  delete lexer;

  return 0;
}
