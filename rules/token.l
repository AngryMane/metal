/*FLEXのルールファイルは以下の構造を持つ *
 * {%
 * Cコード(宣言部)
 * %}
 * 文字種別定義
 * %%
 * トークン定義・還元処理記述
 * %%
 * Cコード
 *
 */

%{
#include <stdio.h>
#include "syntax.hpp"

//#define METAL_DEBUG

#ifdef METAL_DEBUG
#define PRINT(s) printf(s);printf(" ");
#else
#define PRINT(s)
#endif

#define RETURN(TOKEN) memset(yylval.m_string,0,128);memcpy(yylval.m_string,yytext,std::min(yyleng, 128));PRINT(#TOKEN);return TOKEN
#define RETURN_INT(TOKEN) yylval.m_int=std::stoi(yytext);PRINT(#TOKEN);return TOKEN
#define RETURN_FLOAT(TOKEN) yylval.m_float=std::stof(yytext);PRINT(#TOKEN);return TOKEN

%}

%option stack yylineno
 
%x text_state

FLOAT_VAL     \-?[1-9][0-9]*\.[0-9]*f?
INT_VAL       \-?[1-9][0-9]*|0
SPACE         [ \t]*
NEW_LINE      [\n\r]
DIGIT         [0-9]
CHAR          [a-zA-Z]
PARENTHESE_S  \(
PARENTHESE_E  \)
BRACKET_S     \[
BRACKET_E     \]
BRACE_S       \{
BRACE_E       \}
AGL_BRCKT_S   \<
AGL_BRCKT_E   \>
ANPHORA       @
SEMICOLON     ;
SHARP         #
SYMBOL        {CHAR}[0-9a-zA-Z_]*
PLUS          \+
MINUS         \-
ASTER         \*
SLASH         \/
EQUAL         \=



%%

int                       {RETURN(INT_TYPE);}
float                     {RETURN(FLOAT_TYPE);} 
void                      {RETURN(VOID_TYPE);}
string                    {RETURN(STRING_TYPE);}
return                    {RETURN(RETURN);}
def                       {RETURN(DEF);}
true|false                {RETURN(BOOL_VAL);}
{SYMBOL}                  {RETURN(SYMBOL);}
{FLOAT_VAL}               {RETURN_FLOAT(FLOAT_VAL);}
{INT_VAL}                 {RETURN_INT(INT_VAL);}

\"                        {yy_push_state(text_state);}
{SPACE}             
{NEW_LINE}          
{BRACE_S}                 {RETURN(BRACE_S);}
{BRACE_E}                 {RETURN(BRACE_E);}
{SEMICOLON}               {RETURN(SEMICOLON);}
{BRACKET_S}               {RETURN(BRACKET_S);}
{BRACKET_E}               {RETURN(BRACKET_E);}
\=\>                      {RETURN(PROJECTION_ARROW);}
\:\=                      {RETURN(VAR_INIT_DEF);}
\:                        {RETURN(COLON);}
\,                        {RETURN(COMMA);}
{PLUS}                    {RETURN(PLUS);}
{MINUS}                   {RETURN(MINUS);}
{ASTER}                   {RETURN(ASTER);}
{SLASH}                   {RETURN(SLASH);}
{EQUAL}                   {RETURN(EQUAL);}
{PARENTHESE_S}            {RETURN(PARENTHESE_S);}
{PARENTHESE_E}            {RETURN(PARENTHESE_E);}

<text_state>{
[^\"]+  {yymore();}
\\\"    {yymore();}
\"      {yy_pop_state();RETURN(TEXT);}
}

%%

// yyFlexLexerクラスのyywrap関数
// ライブラリ内で定義しているが、リンクしたくないため自前で定義
int yyFlexLexer::yywrap(){
  return 1;
}

