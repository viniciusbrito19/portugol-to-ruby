%{
#include "common.h"
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <string.h>
#include <iostream>

using namespace std;

extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);
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
%token T_PRINTAR
%token T_LEIA

%left T_SOMA T_SUBTRACAO
%left T_MULTIPLICACAO T_DIVISAO
%left NEG

%{
char buffer[1000];
%}

%start inicio
 
%%

inicio:
	algoritmo {
		printf("%s",$1);
	}
;
algoritmo:
	declaracao_algoritmo
	| declaracao_variaveis
	| corpo_programa
	| declaracao_algoritmo declaracao_variaveis
	| declaracao_algoritmo declaracao_variaveis corpo_programa
	;

declaracao_algoritmo:
	T_ALGORITMO classe T_PONTO_VIRGULA {
		printf("class %s \n", $2);
	}
	;

classe:
	T_IDENTIFICADOR 
	;

declaracao_variaveis:
	T_VARIAVEIS declara_Tipo T_FIM_VARIAVEIS {
		printf("\tattr_accessor %s", $2);
	}
	;

declara_Tipo:
	lista_Variaveis tipo_Variavel{
		char *tipovar1 = (char *) malloc (strlen($1)+1);
		strcpy(tipovar1, $1);
		$$ = tipovar1;
	}
	| lista_Variaveis tipo_Variavel declara_Tipo {
		char *tipovar = (char *) malloc (strlen($1)+strlen($3)+1);
		strcpy(tipovar, $1);
		strcat(tipovar, ", ");
		strcat(tipovar, $3);
		$$ = tipovar;
	}	

	;

lista_Variaveis:
	lista_Variaveis T_VIRGULA variavel {
		char *var = (char *) malloc (strlen($1)+strlen($3)+1);
		strcpy(var, $1);
		strcat(var, ", :");
		strcat(var, $3);
		$$ = var;
	}
	| variavel {
		char *var1 = (char *) malloc (strlen($1)+1);
		strcpy(var1, ":");
		strcat(var1, $1);
		$$ = var1;
	}
	;

variavel:
	T_IDENTIFICADOR	{
		$$ = $1;
	}
	|'`' T_IDENTIFICADOR '`' {
		$$ = $1;
	}
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
		char *corpo = (char *) malloc (strlen($2)+1);
		strcpy(corpo, $2);
		strcat(corpo, "\nend");
		$$ = corpo;
	}
	;

lista_funcionalidades:
	atribuicao
	| retorno T_PONTO_VIRGULA
	| funcao_se
	| funcao_enquanto
	| funcao_para
	| funcao_imprima
	;

retorno: 
	T_RETORNE expressao {
		//printf("\nreturn %s",$2);
	}
	| T_RETORNE {
		//printf("\nreturn ");
	}
	;

lvalue: 
	T_IDENTIFICADOR
	| T_IDENTIFICADOR T_ABRE_COLCHETES expressao T_FECHA_COLCHETES{
		char *valor = (char *) malloc (sizeof(char));
		strcpy(valor, $1);
		strcat(valor, $2);
		strcat(valor, " ");
		strcat(valor, $3);
		strcat(valor, " ");
		strcat(valor, $4);
		$$ = valor;
	}
	;


atribuicao:
	lvalue T_ATRIBUICAO expressao T_PONTO_VIRGULA{
		char *atribuicao = (char *) malloc (sizeof(char));
		strcpy(atribuicao, $1);
		strcat(atribuicao, $2);
		strcat(atribuicao, " ");
		strcat(atribuicao, $3);
		strcat(atribuicao, " ");
		strcat(atribuicao, $4);
		$$ = atribuicao;
	}
	;

funcao_se: 
	T_SE expressao T_ENTAO lista_funcionalidades T_SENAO lista_funcionalidades T_FIM_SE{		
		char *funcaose = (char *) malloc (strlen($2)+strlen($4)+strlen($6)+1);
		strcpy(funcaose, "\n\tif ");
		strcat(funcaose, $2);
		strcat(funcaose, "\n\t\t");
		strcat(funcaose, $4);
		strcat(funcaose, "\n\telse ");
		strcat(funcaose, "\n\t\t");
		strcat(funcaose, $6);
		strcat(funcaose, "\n\tend ");
		$$ = funcaose;
		
	}
	| T_SE expressao T_ENTAO lista_funcionalidades T_FIM_SE{
		char *funcaose1 = (char *) malloc (strlen($2)+strlen($4)+1);
		strcpy(funcaose1, "\n\tif ");
		strcat(funcaose1, $2);
		strcat(funcaose1, "\n\t\t");
		strcat(funcaose1, $4);
		strcat(funcaose1, "\n\tend ");
		$$ = funcaose1;
	}
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

funcao_imprima:
	T_IMPRIMA T_ABRE_PARENTESES printar T_FECHA_PARENTESES T_PONTO_VIRGULA
	{ 
		char *fprint = (char *) malloc (sizeof(char));
		strcpy(fprint, "\n\tputs ");
		strcat(fprint, $3 );
		$$ = fprint;
	}
;

printar: 
	printar T_VIRGULA lista_Variaveis T_VIRGULA printar { 
		char *print1 = (char *) malloc (sizeof(char));
		strcpy(print1, $1);
		strcat(print1, ", ");
		strcat(print1, $3);
		strcat(print1, ", ");
		strcat(print1, $5);
		$$ = print1;
	}
	| printar T_VIRGULA lista_Variaveis { 
		char *print2 = (char *) malloc (sizeof(char));
		strcpy(print2, $1);
		strcat(print2, ", ");
		strcat(print2, $3);
		$$ = print2;
	}
	| lista_Variaveis T_VIRGULA printar { 
		char *print3 = (char *) malloc (sizeof(char));
		strcpy(print3, $1);
		strcat(print3, ", ");
		strcat(print3, $3);
		$$ = print3;
	}
	| lista_Variaveis
	| T_PRINTAR
;

funcao_leia: 
	T_LEIA
	{
	printf ("gets");
	}
;
expressao:
	expressao T_OR expressao {		
		char *exp1 = (char *) malloc (sizeof(char));
		strcpy(exp1, $1);
		strcat(exp1, " || ");
		strcat(exp1, $3);
		$$ = exp1;
	}
	| expressao T_OR2 expressao {		
		char *exp2 = (char *) malloc (sizeof(char));
		strcpy(exp2, $1);
		strcat(exp2, " || ");
		strcat(exp2, $3);
		$$ = exp2;
	}
	| expressao T_AND expressao {		
		char *exp3 = (char *) malloc (sizeof(char));
		strcpy(exp3, $1);
		strcat(exp3, " && ");
		strcat(exp3, $3);
		$$ = exp3;
	}
	| expressao T_AND2 expressao {		
		char *exp4 = (char *) malloc (sizeof(char));
		strcpy(exp4, $1);
		strcat(exp4, " && ");
		strcat(exp4, $3);
		$$ = exp4;
	}
	//| expressao "|" expressao
	//| expressao "^" expressao
	//| expressao "&" expressao
	| expressao T_IGUAL expressao {		
		char *exp5 = (char *) malloc (sizeof(char));
		strcpy(exp5, $1);
		strcat(exp5, " = ");
		strcat(exp5, $3);
		$$ = exp5;
	}
	| expressao T_DIFERENTE expressao {
		char *exp6 = (char *) malloc (sizeof(char));
		strcpy(exp6, $1);
		strcat(exp6, " != ");
		strcat(exp6, $3);
		$$ = exp6;
	}
	| expressao T_MAIOR expressao {		
		char *exp7 = (char *) malloc (sizeof(char));
		strcpy(exp7, $1);
		strcat(exp7, $2);
		strcat(exp7, $3);
		$$ = exp7;
	}
	| expressao T_MAIOR_IGUAL expressao {		
		char *exp8 = (char *) malloc (sizeof(char));
		strcpy(exp8, $1);
		strcat(exp8, $2);
		strcat(exp8, $3);
		$$ = exp8;
	}
	| expressao T_MENOR expressao {		
		char *exp9 = (char *) malloc (sizeof(char));
		strcpy(exp9, $1);
		strcat(exp9, $2);
		strcat(exp9, $3);
		$$ = exp9;
	}
	| expressao T_MENOR_IGUAL expressao {		
		char *exp10 = (char *) malloc (sizeof(char));
		strcpy(exp10, $1);
		strcat(exp10, $2);
		strcat(exp10, $3);
		$$ = exp10;
	}
	| expressao T_SOMA expressao {		
		char *exp11 = (char *) malloc (sizeof(char));
		strcpy(exp11, $1);
		strcat(exp11, $2);
		strcat(exp11, $3);
		$$ = exp11;
	}
	| expressao T_SUBTRACAO expressao{		
		char *exp12 = (char *) malloc (sizeof(char));
		strcpy(exp12, $1);
		strcat(exp12, $2);
		strcat(exp12, $3);
		$$ = exp12;
	}
	| expressao T_DIVISAO expressao {		
		char *exp13 = (char *) malloc (sizeof(char));
		strcpy(exp13, $1);
		strcat(exp13, $2);
		strcat(exp13, $3);
		$$ = exp13;
	}
	| expressao T_MULTIPLICACAO expressao {		
		char *exp14 = (char *) malloc (sizeof(char));
		strcpy(exp14, $1);
		strcat(exp14, "*");
		strcat(exp14, $3);
		$$ = exp14;
	}
	| expressao T_PORCENTAGEM expressao {		
		char *exp15 = (char *) malloc (sizeof(char));
		strcpy(exp15, $1);
		strcat(exp15, $2);
		strcat(exp15, $3);
		$$ = exp15;
	}
	| T_SOMA termo {		
		char *exp16 = (char *) malloc (sizeof(char));
		strcpy(exp16, $1);
		strcat(exp16, $2);
		$$ = exp16;
	}
	| T_SUBTRACAO termo {		
		char *exp17 = (char *) malloc (sizeof(char));
		strcpy(exp17, $1);
		strcat(exp17, $2);
		$$ = exp17;
	}
	| termo
	;

termo:
	lvalue
	| literal
	| funcao_leia
	| T_ABRE_PARENTESES expressao T_FECHA_PARENTESES{
		char *termo = (char *) malloc (sizeof(char));
		strcpy(termo, " (");
		strcat(termo, $2);
		strcat(termo, ")");
		$$ = termo;
	}
	;

literal: 
	T_DEC_LIT
	| T_INT_LIT
	| T_REAL_LIT
	| T_PRINTAR
	;

%%
 
void yyerror(const char* errmsg)
{
	printf("\n*** Erro: %s\n", errmsg);
}
 
int main(int argc, char* argv[])
{
	string arqInput;
	string arqOutput;

if(argc == 1)
arqInput = "entrada.prg";
else
arqInput = argv[1];

// Arquivo:
FILE *arquivo = fopen(arqInput.c_str(), "r");

if(arquivo==NULL)
{
perror("Erro! Nao foi possivel abrir seu arquivo. \n");
}

if (!arquivo) {
printf("Desculpe-nos!! Não conseguimos abrir o arquivo: %s! \n", arqInput.c_str());
return -1;
}

//configurando para o flex ler ao invés do STDIN
yyin = arquivo;

do
{
    yyparse();
}while (!feof(yyin));

    return 0;
}
