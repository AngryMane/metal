/*
 *          Bisonによる簡単な表現式パーサ
 */

%code requires{

#include "external.h"
#include "BaseAST.h"
#include "ExpressionAST.h"
#include "BinaryOperatorAST.h"
#include "IntLiteralAST.h"
#include "FloatLiteralAST.h"
#include "VarDeclAST.h"
#include "VarRefAST.h"
#include "FuncCallAST.h"
#include "ReturnAST.h"
#include "FunctionAST.h"
#include "RootAST.h"

}

%{

#include "external.h"
#include "ASTCommon.h"
#include "BaseAST.h"
#include "FlexLexer.h"

// Bisonで生成するコードが参照する関数
// 定義がライブラリ(libfl.a)内に存在する
// ライブラリをリンクしたくないため、自分で定義する。
void yyerror(ParseContext& parse_context, BaseAST** ret, const char *s);

// Bisonで生成するコードが参照する関数
// Flex++はyyFlexLexer::yylex()になるため、ラッパを自前で定義する
int yylex(void);

// flexのインスタンス
yyFlexLexer* lexer;

%}

%union {
  char m_string[128];
  int m_int;
  float m_float;
  bool m_bool;
  BaseAST* m_BaseAST;
  RootAST* m_RootAST;
  FunctionAST* m_FunctionAST;
  ExpressionAST* m_ExpressionAST;
  IntLiteralAST* m_IntLiteralAST;
  FloatLiteralAST* m_FloatLiteralAST;
  VarRefAST* m_VarRefAST;
  std::vector<BaseAST*>* m_BaseASTContainer;
}

%parse-param      {ParseContext& parse_context}
%parse-param      {BaseAST** ret}

%token SYMBOL
%token SEMICOLON
%token TEXT
%token INT_VAL
%token FLOAT_VAL
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
%token FLOAT_TYPE
%token VOID_TYPE
%token STRING_TYPE

%type <m_string> SYMBOL SEMICOLON TEXT BRACKET_S BRACKET_E COLON BRACE_S BRACE_E DEF COMMA PLUS MINUS ASTER SLASH EQUAL VAR_INIT_DEF 
%type <m_string> PROJECTION_ARROW PARENTHESE_S PARENTHESE_E RETURN INT_TYPE VOID_TYPE FLOAT_TYPE STRING_TYPE primary_type 
%type <m_int> INT_VAL
%type <m_float> FLOAT_VAL
%type <m_bool> BOOL_VAL

// root
%type <m_RootAST> root 

// expression
%type <m_ExpressionAST> expression 
%type <m_IntLiteralAST> int_literal 
%type <m_FloatLiteralAST> float_literal 
%type <m_VarRefAST> var_ref  

// function decl
%type <m_FunctionAST> function_decl function_header 

// statement
%type <m_BaseAST> statement var_decl return external_decl
%type <m_BaseASTContainer> var_decls statements function_body 

// priority and associativity of operator
%left PLUS MINUS
%left ASTER SLASH

%%

//--------------------------------------------------------
// global syntax 

root       :                    {$$ = new RootAST();*ret = $$;}
           | external_decl root {$$ = $2;$$->AddDecl($1);}
           ;

external_decl : function_decl  {$$ = $1;}
              | statement {$$ = $1;}
              ;

//--------------------------------------------------------
// function

function_decl : function_header function_body {$$ = $1;$$->SetStatements($2);}
                ;

function_header : DEF SYMBOL COLON PROJECTION_ARROW primary_type           {$$ = new FunctionAST($2, $5);}
                | DEF SYMBOL COLON var_decls PROJECTION_ARROW primary_type {$$ = new FunctionAST($2, $6, *$4);}
                ;

function_body : BRACE_S statements BRACE_E {$$ = $2;}
                ;

//--------------------------------------------------------
// primary type

primary_type : INT_TYPE
             | VOID_TYPE
             | FLOAT_TYPE 
             | STRING_TYPE 
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

var_decl  : primary_type SYMBOL                         {$$ = new VarDeclAST($2, 0, VarDeclAST::VAR_TYPE::VAR_TYPE_LOCAL);}
          | primary_type SYMBOL VAR_INIT_DEF expression {$$ = new VarDeclAST($2, $4, VarDeclAST::VAR_TYPE::VAR_TYPE_LOCAL);}
          ;

return  : RETURN expression {$$ = new ReturnAST($2);}
        | RETURN {$$ = new ReturnAST(NULL);}
        ;

//--------------------------------------------------------
// expression

expression : expression PLUS expression {auto* bi = new BinaryOperatorAST($2, $1, $3);$$ = new ExpressionAST(bi);}
           | expression MINUS expression {auto* bi = new BinaryOperatorAST($2, $1, $3);$$ = new ExpressionAST(bi);}  
           | expression ASTER expression {auto* bi = new BinaryOperatorAST($2, $1, $3);$$ = new ExpressionAST(bi);}
           | expression SLASH expression {auto* bi = new BinaryOperatorAST($2, $1, $3);$$ = new ExpressionAST(bi);}
           | PARENTHESE_S expression PLUS expression PARENTHESE_E {auto* bi = new BinaryOperatorAST($3, $2, $4);$$ = new ExpressionAST(bi);}
           | PARENTHESE_S expression MINUS expression PARENTHESE_E {auto* bi = new BinaryOperatorAST($3, $2, $4);$$ = new ExpressionAST(bi);}
           | PARENTHESE_S expression ASTER expression PARENTHESE_E {auto* bi = new BinaryOperatorAST($3, $2, $4);$$ = new ExpressionAST(bi);}
           | PARENTHESE_S expression SLASH expression PARENTHESE_E {auto* bi = new BinaryOperatorAST($3, $2, $4);$$ = new ExpressionAST(bi);}
           | var_ref {$$ = new ExpressionAST($1);}
           | int_literal {$$ = new ExpressionAST($1);}
           | float_literal {$$ = new ExpressionAST($1);}
           ;

var_ref : SYMBOL {$$ = new VarRefAST("");}
             
int_literal : INT_VAL {$$ = new IntLiteralAST($1);}
              ;

float_literal : FLOAT_VAL {$$ = new FloatLiteralAST($1);}
              ;

//--------------------------------------------------------
// other

var_decls : var_decl                 {$$ = new std::vector<BaseAST*>;$$->push_back($1);}
          | var_decl COMMA var_decls {$$ = $3;$$->push_back($1);}
          ;

//--------------------------------------------------------


%%

void yyerror(ParseContext& parse_context, BaseAST** ret, const char *s){
  std::cout << "Syntax error" << std::endl;
  std::cout << "Reduction failed in:" << std::endl;
  std::cout << "Line :" << lexer->lineno() << std::endl;
  std::cout << "Token:" << lexer->YYText() << std::endl;
}

int yylex(void){
  return lexer->yylex();
}

void
Parse(std::string target){
  std::cout << target << std::endl;
  std::filebuf file;
  bool is_open = file.open(target, std::ios::in);
  if (is_open == false){
    std::cout << "Open target file failed" << std::endl;
    return ;
  }

  std::istream ifs(&file);
  lexer = new yyFlexLexer(&ifs);
  llvm::LLVMContext context;
  llvm::Module *module = new llvm::Module("top", context);
  llvm::IRBuilder<> builder(context);

  ParseContext parse_context(&context, module, &builder);

  BaseAST* ret = NULL;
  yyparse(parse_context, &ret);
  ret->GenerateValue(parse_context);

  std::error_code error_info;
  llvm::raw_fd_ostream raw_stream("out.ll", error_info, llvm::sys::fs::OpenFlags::F_None);
  module->print(raw_stream, nullptr);
  module->print(llvm::outs(), nullptr);
  llvm::WriteBitcodeToFile(module, raw_stream);

  delete lexer;
  delete ret;
}

int main(){
  const std::string TARGET_PATH = "./target/"; 

  DIR* dir = opendir(TARGET_PATH.c_str());
  if (dir == NULL){
    return 0;
  }

  struct dirent* dent = NULL;
  do {
    dent = readdir(dir);
    if (dent  == NULL){
      break;
    }

    if (strcmp(dent->d_name, ".") == 0){
      continue;
    }
    if (strcmp(dent->d_name, "..") == 0){
      continue;
    }

    Parse(TARGET_PATH + dent->d_name);
  } while(dent != NULL);

  return 0;
}
