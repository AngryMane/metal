/*
 * expr.y : Bisonマニュアル中の例に基づく
 *          Bisonによる簡単な表現式パーサ
 */

%code requires{
#include "ParserDef.h"
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

  struct {bool is_terminal_;std::string value_;} terminal_symbol_;
  struct {bool is_terminal_;Data* value_;} non_terminal_symbol_;

  YYSTYPE(){terminal_symbol_.is_terminal_ = false;} 
  ~YYSTYPE(){/*non_terminal_symbol_は外でdeleteする。TODO:unique_ptrを検討する*/}
  YYSTYPE& operator=(const YYSTYPE& rhs){
    terminal_symbol_.is_terminal_ = rhs.terminal_symbol_.is_terminal_;
    if (terminal_symbol_.is_terminal_){
      terminal_symbol_.value_ = rhs.terminal_symbol_.value_;
    } else {
      non_terminal_symbol_.value_ = rhs.non_terminal_symbol_.value_;
    }
    return *this;
  }
}

%token EBGUIDE
%token D_QUATATION
%token ID
%token SYMBOL
%token REFERENCE_ID
%token ARRAY_HEADER
%token START_INSTANCE
%token END_INSTANCE
%token SEMICOLON
%token TEXT
%token VERSION
%token NUMBER
%token BOOL
%token BRACKET_S
%token BRACKET_E
%token COLON

%type  <terminal_symbol_> EBGUIDE D_QUATATION ID SYMBOL REFERENCE_ID
%type  <terminal_symbol_> ARRAY_HEADER START_INSTANCE END_INSTANCE SEMICOLON TEXT VERSION NUMBER BOOL BRACKET_S BRACKET_E COLON

%type  <non_terminal_symbol_> property
%type  <terminal_symbol_> indirect_ref 

%%

input       : EBGUIDE VERSION SEMICOLON file_root {}
            ;
file_root   : REFERENCE_ID instance {}
            ;
instance    : START_INSTANCE properties END_INSTANCE {} 
            ;
properties  : 
            | property properties {}
            ;
property    : ID SYMBOL SYMBOL TEXT SEMICOLON {$$ = {false, new SimpleProperty($1.value_, $2.value_, $3.value_, $4.value_)};}
            | ID SYMBOL SYMBOL indirect_ref SEMICOLON {$$ = {false, new SimpleProperty($1.value_, $2.value_, $3.value_, $4.value_)};}
            | ID SYMBOL SYMBOL NUMBER SEMICOLON {$$ = {false, new SimpleProperty($1.value_, $2.value_, $3.value_, $4.value_)};}
            | ID SYMBOL SYMBOL BOOL SEMICOLON {$$ = {false, new SimpleProperty($1.value_, $2.value_, $3.value_, $4.value_)};}
            | ID SYMBOL SYMBOL indirect_ref instance {$$ = {false, new SimpleProperty($1.value_, $2.value_, $3.value_, $4.value_)};}
            | ID SYMBOL SYMBOL instance_array SEMICOLON {}
            | ID TEXT SYMBOL TEXT SEMICOLON {$$ = {false, new SimpleProperty($1.value_, $2.value_, $3.value_, $4.value_)};}
            | ID TEXT SYMBOL indirect_ref SEMICOLON {$$ = {false, new SimpleProperty($1.value_, $2.value_, $3.value_, $4.value_)};}
            | ID TEXT SYMBOL NUMBER SEMICOLON {$$ = {false, new SimpleProperty($1.value_, $2.value_, $3.value_, $4.value_)};}
            | ID TEXT SYMBOL BOOL SEMICOLON {$$ = {false, new SimpleProperty($1.value_, $2.value_, $3.value_, $4.value_)};}
            | ID TEXT SYMBOL indirect_ref instance {$$ = {false, new SimpleProperty($1.value_, $2.value_, $3.value_, $4.value_)};}
            | ID TEXT SYMBOL instance_array SEMICOLON {}
            ;
indirect_ref: REFERENCE_ID {}
            | REFERENCE_ID ID {}
            ;
instance_array  : ARRAY_HEADER BRACKET_S groups BRACKET_E{} 
                ;
group       : SYMBOL REFERENCE_ID START_INSTANCE properties END_INSTANCE {/*TODO*/}
            ;
groups      : 
            | group 
            | group COLON groups {/*TODO*/}
            ;

%%

void yyerror(const char *s){
  std::cout << "Syntax error" << std::endl;
  std::cout << "Reduction failed in:" << std::endl;
  std::cout << "Line :" << lexer->lineno() << std::endl;
  std::cout << "Token:" << lexer->YYText() << std::endl;
  std::cout << "Invalid gdata" << std::endl;
}

int yylex(void){
  return lexer->yylex();;
}

int main(){
  std::filebuf file;
  bool ret = file.open("./result/target.gdata", std::ios::in);
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
