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
char buffer[1000];
%}

%start algoritmo
 
%%

algoritmo:
	declaracao_algoritmo
	| declaracao_variaveis
	| corpo_programa
	| declaracao_algoritmo declaracao_variaveis
	| declaracao_algoritmo declaracao_variaveis corpo_programa
	;

declaracao_algoritmo:
	T_ALGORITMO classe T_PONTO_VIRGULA {
	printf("Algoritmo ");
	fprintf(arq,"class %s\n",buffer);
	strcpy(buffer,"");}
	;

classe:
	T_IDENTIFICADOR{
	printf("value ");
	strcpy(buffer, yytext);}
	;

declaracao_variaveis:
	T_VARIAVEIS declara_Tipo T_FIM_VARIAVEIS
	{
	printf("Variavel");
	buffer[(strlen(buffer)-1)]=0;
	fprintf(arq,"\n\tattr_accessor %s",buffer);}
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
	printf("variavel ");
	strcat(buffer, " :");
	strcat(buffer, yytext);
	strcat(buffer, ",");}
	| lista_Variaveis T_VIRGULA variavel 
	{
	printf("variavel ");
	strcat(buffer, " :");	
	strcat(buffer, yytext);
	strcat(buffer, ",");}
	;

variavel:
	T_IDENTIFICADOR
	|'`' T_IDENTIFICADOR '`'
	;
 
tipo_Variavel:
	T_RECEBER tipo_primitivo T_PONTO_VIRGULA
	;

tipo_primitivo:
	T_TIPO_INTEIRO
	| T_TIPO_REAL
	| T_TIPO_CARACTERE
	| T_TIPO_LITERAL
	| T_TIPO_LOGICO
	;

corpo_programa:
	T_INICIO lista_funcionalidades T_FIM{
	printf("bloco ");}
	;

lista_funcionalidades:
	atribuicao{
	printf("fatribuicao ");}
	| retorno T_PONTO_VIRGULA{
	printf("fretorne ");}
	| funcao_se{
	printf("fse ");}
	| funcao_enquanto{
	printf("fenquanto ");}
	| funcao_para{
	printf("fpara ");}
	;

retorno
	: T_RETORNE{
	printf("retorne ");} 
	| T_RETORNE expressao{
	printf("retorne x ");}
	;

lvalue: 
	T_IDENTIFICADOR{
	printf("value ");}
	| T_IDENTIFICADOR T_ABRE_COLCHETES expressao T_FECHA_COLCHETES{
	printf("valuecolchetes ");}
	;


atribuicao
	: lvalue T_ATRIBUICAO expressao T_PONTO_VIRGULA{
	printf("Atribuicao ");}
	;

funcao_se
	: T_SE expressao T_ENTAO lista_funcionalidades T_FIM_SE{
	printf("SE ");}
	| T_SE expressao T_ENTAO lista_funcionalidades T_SENAO lista_funcionalidades T_FIM_SE{
	printf("SESENAO ");}
	;

funcao_enquanto
	: T_ENQUANTO expressao T_FACA lista_funcionalidades T_FIM_ENQUANTO{
	printf("Enquanto ");}
	;

funcao_para
	: T_PARA lvalue T_DE expressao T_ATE expressao T_FACA lista_funcionalidades T_FIM_PARA{
	printf("Para ");}
	| T_PARA lvalue T_DE expressao T_ATE expressao passo T_FACA lista_funcionalidades T_FIM_PARA{
	printf("ParaPasso ");}
	;

passo
	: "passo" | "+"|"-" T_INT_LIT
	;

expressao:
	expressao T_OR expressao
	| expressao T_OR2 expressao
	| expressao T_AND expressao
	| expressao T_AND2 expressao
	//| expressao "|" expressao
	//| expressao "^" expressao
	//| expressao "&" expressao
	| expressao T_IGUAL expressao
	| expressao T_DIFERENTE expressao
	| expressao T_MAIOR expressao{
	printf("> ");}
	| expressao T_MAIOR_IGUAL expressao{
	printf(">= ");}
	| expressao T_MENOR expressao{
	printf("< ");}
	| expressao T_MENOR_IGUAL expressao{
	printf("<= ");}
	| expressao T_SOMA expressao
	| expressao T_SUBTRACAO expressao
	| expressao T_DIVISAO expressao
	| expressao T_MULTIPLICACAO expressao
	| expressao T_PORCENTAGEM expressao
	| T_SOMA termo{
	printf("+termo ");}
	| T_SUBTRACAO termo{
	printf("-termo ");}
	| termo{
	printf("termo ");}
	;

termo:
	lvalue{
	printf("lvalue ");}
	| literal{
	printf("literal ");}
	| T_ABRE_PARENTESES expressao T_FECHA_PARENTESES{
	printf("(expressao) ");}
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
    arq = fopen("Arquivos/saida.rb","w");
    fflush(arq);
    
    yyparse();
    
    fprintf(arq,"\nend");
    fclose(arq);

    return 0;
}
