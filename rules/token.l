/*FLEXのルールファイルは以下の構造を持つ
 *
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

//#define DEBUG

#ifdef DEBUG
#define PRINT(s) printf(s);printf(" ");
#else
#define PRINT(s)
#endif

#define RETURN(TOKEN) PRINT(#TOKEN);return TOKEN

%}

%option stack yylineno
 
%x text_state
%x version_state

NUMBER_       \-?([1-9][0-9]*)?[0-9]?(\.[0-9]*[Ff]?)?
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
SYMBOL        {CHAR}[0-9a-zA-Z_\(\)\,]*


%%

EBGUIDE                   {yy_push_state(version_state);RETURN(EBGUIDE);}
true|false                {RETURN(BOOL);}
{SHARP}{DIGIT}+           {RETURN(ID);}
{ANPHORA}[a-zA-Z0-9\-]+   {RETURN(REFERENCE_ID);}
{SYMBOL}                  {RETURN(SYMBOL);}
{AGL_BRCKT_S}{SYMBOL}{AGL_BRCKT_E}             {RETURN(ARRAY_HEADER);}
{NUMBER_}                 {RETURN(NUMBER);}

::
:/[^:]
\"                        {yy_push_state(text_state);}
{SPACE}             
{NEW_LINE}          
{BRACE_S}                 {RETURN(START_INSTANCE);}
{BRACE_E}                 {RETURN(END_INSTANCE);}
{SEMICOLON}               {RETURN(SEMICOLON);}
{BRACKET_S}               {RETURN(BRACKET_S);}
{BRACKET_E}               {RETURN(BRACKET_E);}
\,                        {RETURN(COLON);}

<text_state>{
[^\"]+  {yymore();}
\\\"    {yymore();}
\"      {yy_pop_state();RETURN(TEXT);}
}

<version_state>{
{SPACE}             
[^;]*         {RETURN(VERSION);}
{SEMICOLON}   {yy_pop_state();RETURN(SEMICOLON);}
}

%%

// yyFlexLexerクラスのyywrap関数
// ライブラリ内で定義しているが、リンクしたくないため自前で定義
int yyFlexLexer::yywrap(){
  return 1;
}

