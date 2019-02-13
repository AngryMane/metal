/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_SRC_SYNTAX_HPP_INCLUDED
# define YY_YY_SRC_SYNTAX_HPP_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 5 "rules/syntax.y" /* yacc.c:1909  */


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


#line 61 "src/syntax.hpp" /* yacc.c:1909  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    SYMBOL = 258,
    SEMICOLON = 259,
    TEXT = 260,
    INT_VAL = 261,
    FLOAT_VAL = 262,
    BOOL_VAL = 263,
    BRACKET_S = 264,
    BRACKET_E = 265,
    COLON = 266,
    BRACE_S = 267,
    BRACE_E = 268,
    DEF = 269,
    COMMA = 270,
    PLUS = 271,
    MINUS = 272,
    ASTER = 273,
    SLASH = 274,
    EQUAL = 275,
    VAR_INIT_DEF = 276,
    PROJECTION_ARROW = 277,
    PARENTHESE_S = 278,
    PARENTHESE_E = 279,
    RETURN = 280,
    INT_TYPE = 281,
    FLOAT_TYPE = 282,
    VOID_TYPE = 283,
    STRING_TYPE = 284
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 43 "rules/syntax.y" /* yacc.c:1909  */

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
  std::vector<BaseAST*>* m_BaseASTContainer;

#line 117 "src/syntax.hpp" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (ParseContext& parse_context, BaseAST** ret);

#endif /* !YY_YY_SRC_SYNTAX_HPP_INCLUDED  */
