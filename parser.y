%{
#include "common.h"
#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "funcao.c"
FILE *arq;
%}

%token T_IDENTIFICADOR
%token T_INT_LIT
%token T_REAL_LIT
%token String

%{
char str1[1000];
char buffer[1000];
extern char* yytext;
%}

%start algoritmo
 
%%

algoritmo
	: declaracao_algoritmo {
	printf("Nhe");}
	;

declaracao_algoritmo
	: "algoritmo" T_IDENTIFICADOR ";" {
	printf("Nhe");}
	;

var_decl_block
	: "variáveis" var_decl ";" "fim-variáveis"
	;

var_decl
	: T_IDENTIFICADOR | "," T_IDENTIFICADOR ":" | tp_primitivo | tp_matriz var_decl
	;

tp_primitivo
	: "inteiro"
	| "real"
	| "caractere"
	| "literal"
	| "lógico"
	;

tp_matriz
	: "matriz" "[" T_INT_LIT "]" "de" tp_prim_pl
	;

tp_prim_pl
	: "inteiros"
	| "reais"
	| "caracteres"
	| "literais"
	| "lógicos"
	;

stm_block
	: "início" stm_list "fim"
	;

stm_list
	:stm_attr stm_list
	| fcall ";"
	| stm_ret stm_list
	| stm_se stm_list
	| stm_enquanto stm_list
	| stm_para stm_list
	;

stm_ret
	: "retorne" | expr ";"
	;

lvalue
	: T_IDENTIFICADOR lexpr
	;

lexpr
	:"[" expr "]" lexpr

stm_attr
	: lvalue ":=" expr ";"
	;

stm_se
	: "se" expr "então" stm_list | "senão" stm_list | "fim-se"
	;

stm_enquanto
	: "enquanto" expr "faça" stm_list "fim-enquanto"
	;

stm_para
	: "para" lvalue "de" expr "até" expr | passo "faça" stm_list "fim-para"
	;

passo
	: "passo" | "+"|"-" T_INT_LIT
	;

expr
	: expr "ou" | "||" expr
	| expr "e" | "&&" expr
	| expr "|" expr
	| expr "^" expr
	| expr "&" expr
	| expr "=" | "<>" | expr
	| expr ">" | ">=" | "<" | "<=" expr
	| expr "+" | "-" expr
	| expr "/" | "*" | "%" expr
	| "+" | "-" | "~" | "não" termo
	;

termo
	:fcall
	| lvalue
	| literal
	| "(" expr ")"
	;

fcall
	: T_IDENTIFICADOR "(" |fargs ")"
	;

fargs
	: expr "," expr
	;

literal
	: T_INT_LIT
	| T_REAL_LIT
	;

%%
 
void yyerror(const char* errmsg)
{
	printf("\n*** Erro: %s\n", errmsg);
}
 
int main(int argc, char** argv)
{
     yyparse();

     return 0;
}
