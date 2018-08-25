/*
 * expr.y : Bisonマニュアル中の例に基づく
 *          Bisonによる簡単な表現式パーサ
 */

%code requires{
#include "ParserDef.h"
#include "BinaryOperatorAST.h"
}

%{

#include "FlexLexer.h"

// Bisonで生成するコードが参照する関数
// 定義がライブラリ(libfl.a)内に存在する
// ライブラリをリンクしたくないため、自分で定義する。
void yyerror(const char *s);

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
}

%token SYMBOL
%token SEMICOLON
%token TEXT
%token INTEGER
%token BOOL
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
%token INT
%token VOID

%type <m_string> SYMBOL SEMICOLON TEXT BRACKET_S BRACKET_E COLON BRACE_S BRACE_E DEF COMMA PLUS MINUS ASTER SLASH EQUAL VAR_INIT_DEF PROJECTION_ARROW PARENTHESE_S PARENTHESE_E RETURN INT VOID
%type <m_int> INTEGER 
%type <m_bool> BOOL 

%type <m_int> expression add_expression multi_expression base_expression 

%%

root       :
           | external_decl root
           ;

external_decl : function_decl 
              ;

function_decl : projection_info function_body 
              ;

projection_info : DEF SYMBOL COLON var_decls PROJECTION_ARROW primary_type 
                ;

function_body : BRACE_S sentences BRACE_E
              ;

//--------------------------------------------------------
// primary type

primary_type : INT
             | VOID
             ;

//--------------------------------------------------------
// sentence

sentences :
          | sentence sentences 
          ;

sentence : var_decl SEMICOLON
         | RETURN expression SEMICOLON
         | function_call SEMICOLON
         ;

var_decls : var_decl 
          | var_decl COMMA var_decls
          ;

var_decl  : primary_type SYMBOL
          | primary_type SYMBOL VAR_INIT_DEF expression
          ;

function_call : SYMBOL PARENTHESE_S function_args PARENTHESE_E
              ;

function_args : 
              | SYMBOL 
              | SYMBOL COMMA SYMBOL 
              ;

//--------------------------------------------------------
// expression

expression : add_expression
           ;

add_expression : multi_expression PLUS multi_expression {$$ = $1 + $3;}
               | multi_expression MINUS multi_expression{$$ = $1 - $3;}
               | multi_expression                       {$$ = $1;}
               ;

multi_expression : base_expression                       {$$ = $1;}
                 | base_expression ASTER base_expression {$$ = $1 * $3;}
                 | base_expression SLASH base_expression {$$ = $1 / $3;}
                 ;

base_expression : INTEGER                                  {$$ = $1;}
                | SYMBOL                                   {$$ = 0;}
                | PARENTHESE_S add_expression PARENTHESE_E {$$ = $2;}
                ;

%%

void yyerror(const char *s){
  std::cout << "Syntax error" << std::endl;
  std::cout << "Reduction failed in:" << std::endl;
  std::cout << "Line :" << lexer->lineno() << std::endl;
  std::cout << "Token:" << lexer->YYText() << std::endl;
}

int yylex(void){
  return lexer->yylex();;
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
  yyparse();
  delete lexer;

  return 0;
}
