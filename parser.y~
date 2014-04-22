%{
#include "common.h"
#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "funcao.c"
FILE *arq;
%}

//%token T_STRING 
/*%token T_ALGORITMO
%token T_DIGIT
%token T_ENTAO
%token T_FIM
%token T_FIM_SE
%token T_FIM_VARIAVEIS
%token T_IMPRIMA
%token T_NOME_VARIAVEL
%token T_PARA
%token T_PONTO_VIRGULA
%token T_RECEBER
%token T_SE
%token T_SENAO
%token T_TIPO_INTEIRO
%token T_TIPO_CARACTERE
%token T_TIPO_REAL
%token T_TIPO_LOGICO
%token T_TIPO_LITERAL
%token T_VIRGULA
%token T_VARIAVEIS*/
%token T_IDENTIFICADOR
//%token T_STRING_LIT
%token T_INT_LIT
%token T_REAL_LIT
//%token T_CARAC_LIT
//%token T_KW_VERDADEIRO
//%token T_KW_FALSO
//RT-AN66R(U)
//RT-AC66
%{
char str1[1000];
char buffer[1000];
extern char* yytext;
%}

%error-verbose
 
%%

/*stmt:
	Declaracao
;

Declara_Tipo:
		Lista_Variaveis Tipo_Variavel
;

Declaracao:
		Declara_Tipo

	|	T_VARIAVEIS Declaracao Declara_Tipo T_FIM_VARIAVEIS
{
arq = fopen("teste.rb","a");
fprintf(arq,"def \n %s \n end", str1);
fclose(arq);
}
;

Lista_Variaveis:
		Variavel
{
strcpy(buffer, yytext);
strcat(str1, buffer);
}
	|	Lista_Variaveis T_VIRGULA Variavel 
{
strcpy(buffer, yytext);
strcat(str1, buffer);
}
;

Variavel:
		T_NOME_VARIAVEL
	|	'`' T_NOME_VARIAVEL '`'
;
 
Tipo_Variavel:
	T_RECEBER T_TIPO_INTEIRO T_PONTO_VIRGULA

	| T_RECEBER T_TIPO_CARACTERE T_PONTO_VIRGULA

	| T_RECEBER T_TIPO_REAL T_PONTO_VIRGULA

	| T_RECEBER T_TIPO_LOGICO T_PONTO_VIRGULA

	| T_RECEBER T_TIPO_LITERAL T_PONTO_VIRGULA
;*/

algoritmo
	: declaracao_algoritmo (var_decl_block)? stm_block (func_decls)*
	;

declaracao_algoritmo
	: "algoritmo" T_IDENTIFICADOR ";"
	;

var_decl_block
	: "variáveis" (var_decl ";")+ "fim-variáveis"
	;

var_decl
	: T_IDENTIFICADOR ("," T_IDENTIFICADOR)* ":" (tp_primitivo | tp_matriz)
	;

tp_primitivo
	: "inteiro"
	| "real"
	| "caractere"
	| "literal"
	| "lógico"
	;

tp_matriz
	: "matriz" ("[" T_INT_LIT "]")+ "de" tp_prim_pl
	;

tp_prim_pl
	: "inteiros"
	| "reais"
	| "caracteres"
	| "literais"
	| "lógicos"
	;

stm_block
	: "início" (stm_list)* "fim"
	;

stm_list
	:stm_attr
	| fcall ";"
	| stm_ret
	| stm_se
	| stm_enquanto
	| stm_para
	;

stm_ret
	: "retorne" expr? ";"
	;

lvalue
	: T_IDENTIFICADOR ("[" expr "]")*
	;

stm_attr
	: lvalue ":=" expr ";"
	;

stm_se
	: "se" expr "então" stm_list ("senão" stm_list)? "fim-se"
	;

stm_enquanto
	: "enquanto" expr "faça" stm_list "fim-enquanto"
	;

stm_para
	: "para" lvalue "de" expr "até" expr passo? "faça" stm_list "fim-para"
	;

passo
	: "passo" ("+"|"-")? T_INT_LIT
	;

expr
	: expr ("ou"|"||") expr
	| expr ("e"|"&&") expr
	| expr "|" expr
	| expr "^" expr
	| expr "&" expr
	| expr ("="|"<>") expr
	| expr (">"|">="|"<"|"<=" expr
	| expr ("+" | "-") expr
	| expr ( "/"|"*"|"%") expr
	| ("+"|"-"|"~"|"não")? termo
	;

termo
	:fcall
	| lvalue
	| literal
	| "(" expr ")"
	;

fcall
	: T_IDENTIFICADOR "(" fargs? ")"
	;

fargs
	: expr ("," expr)*
	;

literal
	: T_INT_LIT
	| T_REAL_LIT
	;

func_decls
	: "função" T_IDENTIFICADOR "(" fparams? ")" (":" tb_primitivo)?
		fvar_decl
		stm_block
	;

fvar_decl
	: (var_decl ";")*
	;

fparams
	:fparam ("," fparam)*
	;

fparam
	: T_IDENTIFICADOR ":" (tp_primitivo | tp_matriz)
	;

%%
 
void yyerror(const char* errmsg)
{
	printf("\n*** Erro: %s\n", errmsg);
}
 
int yywrap(void) { return 1; }
 
int main(int argc, char** argv)
{
     yyparse();

     return 0;
}
