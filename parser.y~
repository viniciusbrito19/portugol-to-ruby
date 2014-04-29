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
%token T_STRING
%token T_ABRE_PARENTESES
%token T_ABRE_COLCHETES 
%token T_ALGORITMO
%token T_ATE
%token T_RETORNE
%token T_AND
%token T_AND2
%token T_ATRIBUICAO
%token T_CONDICAO
%token T_DE
%token T_DEC_LIT
%token T_DIFERENTE
%token T_DIGIT
%token T_DIVISAO
%token T_ENQUANTO
%token T_ENTAO
%token T_FACA
%token T_FECHA_PARENTESES
%token T_FECHA_COLCHETES
%token T_FIM
%token T_FIM_ENQUANTO
%token T_FIM_PARA
%token T_FIM_SE
%token T_FIM_VARIAVEIS
%token T_IGUAL
%token T_IMPRIMA
%token T_INICIO
%token T_MAIOR_IGUAL
%token T_MENOR_IGUAL
%token T_MAIOR
%token T_MENOR
%token T_MULTIPLICACAO
%token T_NOME_VARIAVEL
%token T_OR
%token T_OR2
%token T_PARA
%token T_PONTO_VIRGULA
%token T_PORCENTAGEM
%token T_RECEBER
%token T_SE
%token T_SENAO
%token T_SOMA
%token T_SUBTRACAO
%token T_TIPO_INTEIRO
%token T_TIPO_CARACTERE
%token T_TIPO_REAL
%token T_TIPO_LOGICO
%token T_TIPO_LITERAL
%token T_VIRGULA
%token T_VARIAVEIS


%left T_SOMA T_SUBTRACAO
%left T_MULTIPLICACAO T_DIVISAO
%left NEG


%{
char str1[1000];
char buffer[1000];
extern char* yytext;
%}

%start algoritmo
 
%%

algoritmo:
	declaracao_algoritmo | var_decl_block | stm_block
	;

declaracao_algoritmo:
	T_ALGORITMO T_IDENTIFICADOR T_PONTO_VIRGULA {
	printf("Algoritmo ");}
	;

var_decl_block:
	T_VARIAVEIS declara_Tipo T_FIM_VARIAVEIS
	{
	printf("Variavel ");}
	;

declara_Tipo:
	lista_Variaveis tipo_Variavel
	{
	printf("DeclaraVariavel ");}
	| lista_Variaveis tipo_Variavel declara_Tipo
	{
	printf("Declara+Variavel ");}
	;

lista_Variaveis:
	variavel
	{
	printf("Nhe5");}
	| lista_Variaveis T_VIRGULA variavel 
	{
	printf("Nhe6");}
	;

variavel:
	T_IDENTIFICADOR
	|'`' T_IDENTIFICADOR '`'
	;
 
tipo_Variavel:
	T_RECEBER tp_primitivo T_PONTO_VIRGULA
	;

tp_primitivo:
	T_TIPO_INTEIRO
	| T_TIPO_REAL
	| T_TIPO_CARACTERE
	| T_TIPO_LITERAL
	| T_TIPO_LOGICO
	;

stm_block:
	T_INICIO stm_list T_FIM{
	printf("bloco ");}
	;

stm_list:
	stm_attr{
	printf("fatribuicao ");}
	| fcall T_PONTO_VIRGULA{
	printf("ffcall ");}
	| stm_ret T_PONTO_VIRGULA{
	printf("fretorne ");}
	| stm_se{
	printf("fse ");}
	| stm_enquanto{
	printf("fenquanto ");}
	| stm_para{
	printf("fpara ");}
	;

stm_ret
	: T_RETORNE{
	printf("retorne ");} 
	| T_RETORNE expr{
	printf("retorne x ");}
	;

lvalue: 
	T_IDENTIFICADOR{
	printf("value ");}
	| T_IDENTIFICADOR T_ABRE_COLCHETES expr T_FECHA_COLCHETES{
	printf("valuecolchetes ");}
	;


stm_attr
	: lvalue T_ATRIBUICAO expr T_PONTO_VIRGULA{
	printf("Atribuicao ");}
	;

stm_se
	: T_SE expr T_ENTAO stm_list T_FIM_SE{
	printf("SE ");}
	| T_SE expr T_ENTAO stm_list T_SENAO stm_list T_FIM_SE{
	printf("SESENAO ");}
	;

stm_enquanto
	: T_ENQUANTO expr T_FACA stm_list T_FIM_ENQUANTO{
	printf("Enquanto ");}
	;

stm_para
	: T_PARA lvalue T_DE expr T_ATE expr T_FACA stm_list T_FIM_PARA{
	printf("Para ");}
	| T_PARA lvalue T_DE expr T_ATE expr passo T_FACA stm_list T_FIM_PARA{
	printf("ParaPasso ");}
	;

passo
	: "passo" | "+"|"-" T_INT_LIT
	;

expr:
	expr T_OR expr
	| expr T_OR2 expr
	| expr T_AND expr
	| expr T_AND2 expr
	//| expr "|" expr
	//| expr "^" expr
	//| expr "&" expr
	| expr T_IGUAL expr
	| expr T_DIFERENTE expr
	| expr T_MAIOR expr{
	printf("> ");}
	| expr T_MAIOR_IGUAL expr{
	printf(">= ");}
	| expr T_MENOR expr{
	printf("< ");}
	| expr T_MENOR_IGUAL expr{
	printf("<= ");}
	| expr T_SOMA expr
	| expr T_SUBTRACAO expr
	| expr T_DIVISAO expr
	| expr T_MULTIPLICACAO expr
	| expr T_PORCENTAGEM expr
	| T_SOMA termo{
	printf("+termo ");}
	| T_SUBTRACAO termo{
	printf("-termo ");}
	| termo{
	printf("termo ");}
	;

termo
	:fcall{
	printf("fcall ");}
	| lvalue{
	printf("lvalue ");}
	| literal{
	printf("literal ");}
	| T_ABRE_PARENTESES expr T_FECHA_PARENTESES{
	printf("(expr) ");}
	;

fcall
	: T_IDENTIFICADOR
	| T_IDENTIFICADOR T_ABRE_PARENTESES fargs T_FECHA_PARENTESES
	;

fargs
	: expr
	| fargs T_VIRGULA expr
	;

literal
	: T_DEC_LIT
	| T_INT_LIT
	| T_REAL_LIT
	| T_STRING
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
