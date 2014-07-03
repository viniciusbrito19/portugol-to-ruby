/* A Bison parser, made by GNU Bison 2.5.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2011 Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     T_IDENTIFICADOR = 258,
     T_INT_LIT = 259,
     T_REAL_LIT = 260,
     T_STRING = 261,
     T_ABRE_PARENTESES = 262,
     T_ABRE_COLCHETES = 263,
     T_ALGORITMO = 264,
     T_ATE = 265,
     T_RETORNE = 266,
     T_AND = 267,
     T_AND2 = 268,
     T_ATRIBUICAO = 269,
     T_CONDICAO = 270,
     T_DE = 271,
     T_DEC_LIT = 272,
     T_DIFERENTE = 273,
     T_DIGIT = 274,
     T_DIVISAO = 275,
     T_ENQUANTO = 276,
     T_ENTAO = 277,
     T_FACA = 278,
     T_FECHA_PARENTESES = 279,
     T_FECHA_COLCHETES = 280,
     T_FIM = 281,
     T_FIM_ENQUANTO = 282,
     T_FIM_PARA = 283,
     T_FIM_SE = 284,
     T_FIM_VARIAVEIS = 285,
     T_IGUAL = 286,
     T_IMPRIMA = 287,
     T_INICIO = 288,
     T_MAIOR_IGUAL = 289,
     T_MENOR_IGUAL = 290,
     T_MAIOR = 291,
     T_MENOR = 292,
     T_MULTIPLICACAO = 293,
     T_NOME_VARIAVEL = 294,
     T_OR = 295,
     T_OR2 = 296,
     T_PARA = 297,
     T_PONTO_VIRGULA = 298,
     T_PORCENTAGEM = 299,
     T_RECEBER = 300,
     T_SE = 301,
     T_SENAO = 302,
     T_SOMA = 303,
     T_SUBTRACAO = 304,
     T_TIPO_INTEIRO = 305,
     T_TIPO_CARACTERE = 306,
     T_TIPO_REAL = 307,
     T_TIPO_LOGICO = 308,
     T_TIPO_LITERAL = 309,
     T_VIRGULA = 310,
     T_VARIAVEIS = 311,
     T_PRINTAR = 312,
     T_LEIA = 313,
     T_PASSO = 314,
     NEG = 315
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
} YYLTYPE;
# define yyltype YYLTYPE /* obsolescent; will be withdrawn */
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif

extern YYLTYPE yylloc;

