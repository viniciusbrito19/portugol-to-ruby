%{
#include "common.h"
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <string.h>
#include <iostream>
#include <ctype.h>
#include "tslib.h"

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
%token T_PASSO

%left T_SOMA T_SUBTRACAO
%left T_MULTIPLICACAO T_DIVISAO
%left NEG

%{
char buffer[1000];
char nomeClasse[100];
char *valorTabSimb;
struct TS *tabSimb = NULL;
int cont1=0,cont2=0;
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
	| declaracao_algoritmo declaracao_variaveis{
		char *declaracao1 = (char *) malloc (strlen($1)+strlen($2)+1);
		strcpy(declaracao1, $1);
		strcat(declaracao1, $2);
		$$ = declaracao1;
	}
	| declaracao_algoritmo declaracao_variaveis corpo_programa{
		char *declaracao2 = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(declaracao2, $1);
		strcat(declaracao2, $2);
		strcat(declaracao2, $3);
		$$ = declaracao2;
	}
	;

declaracao_algoritmo:
	T_ALGORITMO T_IDENTIFICADOR T_PONTO_VIRGULA {
		char *declara1 = (char *) malloc (strlen($2)+1);
		strcpy(declara1, "class ");
		strcat(declara1, $2);
		strcpy(nomeClasse,$2);
		strcat(declara1, " \n");
		$$ = declara1;
	}
	;

classe:
	T_IDENTIFICADOR 
	;

declaracao_variaveis:
	T_VARIAVEIS declara_Tipo T_FIM_VARIAVEIS 
	{
		char *declaraVar = (char *) malloc (strlen($2)+27);
		strcpy(declaraVar, "attr_accessor ");
		strcat(declaraVar, $2);
		strcat(declaraVar, " \n\ndef main");
		$$ = declaraVar;
		listar(tabSimb);
	}
	;

declara_Tipo:
	lista_Variaveis tipo_Variavel{
		char *tipovar1 = (char *) malloc (strlen($1)+1);
		strcpy(tipovar1," :");
		strcat(tipovar1, $1);
		$$ = tipovar1;
	}
	| lista_Variaveis tipo_Variavel declara_Tipo {
		char *tipovar = (char *) malloc (strlen($1)+strlen($3)+3);
		strcpy(tipovar, " :");
		strcat(tipovar, $1);
		strcat(tipovar, ", ");
		strcat(tipovar, $3);
		$$ = tipovar;
	}	

	;

lista_Variaveis:
	lista_Variaveis T_VIRGULA variavel {
		char *var = (char *) malloc (strlen($1)+strlen($3)+4);
		strcpy(var, $1);
		strcat(var, ", :");
		strcat(var, $3);
		$$ = var;
	}
	| variavel {
		char *var1 = (char *) malloc (strlen($1)+2);
		strcat(var1, $1);
		$$ = var1;
	}
	;

variavel:
	T_IDENTIFICADOR	{
		$$ = $1;
		tabSimb = incluiNome(tabSimb, $1);
		cont2++;
	}
	|'`' T_IDENTIFICADOR '`' {
		$$ = $1;
		tabSimb = incluiNome(tabSimb, $1);
		cont2++;
	}
	;
 
tipo_Variavel:
	T_RECEBER tipo_primitivo T_PONTO_VIRGULA
	;

tipo_primitivo:
	T_TIPO_INTEIRO {
		tabSimb = geraTipos(tabSimb, "int", cont1, (cont2-1));
		cont1=cont2;
	}
	| T_TIPO_REAL {
		tabSimb = geraTipos(tabSimb, "double", cont1, (cont2-1));
		cont1=cont2;
	}
	| T_TIPO_CARACTERE {
		tabSimb = geraTipos(tabSimb, "char", cont1, (cont2-1));
		cont1=cont2;
	}
	| T_TIPO_LITERAL {
		tabSimb = geraTipos(tabSimb, "String", cont1, (cont2-1));
		cont1=cont2;
	}
	| T_TIPO_LOGICO {
		tabSimb = geraTipos(tabSimb, "bool", cont1, (cont2-1));
		cont1=cont2;
	}
	;

corpo_programa:
	T_INICIO corpo_lista T_FIM{
		char *corpo = (char *) malloc (strlen($2)+140);
		strcpy(corpo, $2);
		strcat(corpo, "\nend\nend");
		strcat(corpo, "\nobj = ");
		strcat(corpo, nomeClasse);
		strcat(corpo, ".new()\nobj.main");
		$$ = corpo;
	}
	;

corpo_lista:
	corpo_lista lista_funcionalidades{
		char *corpoLista1 = (char *) malloc (strlen($1)+strlen($2)+1);
		strcpy(corpoLista1, $1);
		strcat(corpoLista1, $2);
		$$ = corpoLista1;
	}
	|lista_funcionalidades
	{
		char *corpoLista2 = (char *) malloc (strlen($1)+1);
		strcpy(corpoLista2, $1);
		$$ = corpoLista2;
	}
;

lista_funcionalidades:
	atribuicao lista_funcionalidades
	{
		char *func12 = (char *) malloc (strlen($1)+strlen($2));
		strcpy(func12, $1);
		strcat(func12, $2);
		$$ = func12;
	}
	| atribuicao 
	{
		char *func = (char *) malloc (strlen($1));
		strcat(func, $1);
		$$ = func;
	}
	| retorno T_PONTO_VIRGULA
	{
		char *retorne = (char *) malloc (strlen($1));
		strcat(retorne, $1);
		$$ = retorne;
	}
	| funcao_se lista_funcionalidades
	{
		char *func31 = (char *) malloc (strlen($1)+strlen($2));
		strcpy(func31, $1);
		strcat(func31, $2);
		$$ = func31;
	}
	| funcao_se
	{
		char *func2 = (char *) malloc (strlen($1));
		strcat(func2, $1);
		$$ = func2;
	}
	| funcao_enquanto lista_funcionalidades
	{
		char *func51 = (char *) malloc (strlen($1)+strlen($2));
		strcpy(func51, $1);
		strcat(func51, $2);
		$$ = func51;
	}
	| funcao_enquanto
	{
		char *func3 = (char *) malloc (strlen($1));
		strcat(func3, $1);
		$$ = func3;
	}
	| funcao_para lista_funcionalidades
	{
		char *func61 = (char *) malloc (strlen($1)+strlen($2));
		strcpy(func61, $1);
		strcat(func61, $2);
		$$ = func61;
	}
	| funcao_para
	{
		char *func4 = (char *) malloc (strlen($1));
		strcat(func4, $1);
		$$ = func4;
	}
	| funcao_imprima lista_funcionalidades
	{
		char *func71 = (char *) malloc (strlen($1)+strlen($2));
		strcpy(func71, $1);
		strcat(func71, $2);
		$$ = func71;
	}
	| funcao_imprima
	{
		char *func5 = (char *) malloc (strlen($1));
		strcat(func5, $1);
		$$ = func5;
	}
	;

retorno: 
	T_RETORNE expressao 
	{
		char *retorne1 = (char *) malloc (strlen($2)+8);
		strcpy(retorne1, "return ");
		strcat(retorne1, $2);
		$$ = retorne1;
	}
	| T_RETORNE {
		char *retorne2 = (char *) malloc (sizeof(char));
		strcpy(retorne2, "return ");
		$$ = retorne2;
	}
	;

lvalue: 
	T_IDENTIFICADOR
	| T_IDENTIFICADOR T_ABRE_COLCHETES expressao T_FECHA_COLCHETES{
		char *valor = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+strlen($4)+3);
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
	variavel T_ATRIBUICAO expressao T_PONTO_VIRGULA{
		char *atribuicao = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+strlen($4)+5);
		strcpy(atribuicao,"\n\t");
		strcat(atribuicao, "@");
		strcat(atribuicao, $1);
		strcat(atribuicao, "=");
		strcat(atribuicao, $3);
		strcat(atribuicao, "\n");
		$$ = atribuicao;
	}
	;

funcao_se: 
	T_SE expressao T_ENTAO lista_funcionalidades T_SENAO lista_funcionalidades T_FIM_SE{		
		char *funcaose = (char *) malloc (strlen($2)+strlen($4)+strlen($6)+30);
		strcpy(funcaose, "\n\tif @");
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
		char *funcaose1 = (char *) malloc (strlen($2)+strlen($4)+20);
		strcpy(funcaose1, "\n\tif @");
		strcat(funcaose1, $2);
		strcat(funcaose1, "\n\t\t");
		strcat(funcaose1, $4);
		strcat(funcaose1, "\n\tend ");
		$$ = funcaose1;
	}
	;

funcao_enquanto
	: T_ENQUANTO expressao T_FACA lista_funcionalidades T_FIM_ENQUANTO{
		char *enquanto = (char *) malloc (strlen($2)+strlen($4)+18);
		strcpy(enquanto, "\n\twhile ");
		strcat(enquanto, $2);
		strcat(enquanto, "\n\t\t");
		strcat(enquanto, $4);
		strcat(enquanto, "\n\tend ");
		$$ = enquanto;
	}
	;

funcao_para
	: T_PARA lvalue T_DE expressao T_ATE expressao T_FACA lista_funcionalidades T_FIM_PARA
	{
		char *para1 = (char *) malloc (strlen($2)+strlen($4)+strlen($6)+strlen($8)+30);
		strcpy(para1, "\n\tfor @");
		strcat(para1, $2);
		strcat(para1, " in ");
		strcat(para1, $4);
		strcat(para1, "..@");
		strcat(para1, $6);
		strcat(para1, ".to_i");
		strcat(para1, "\n");
		strcat(para1, $8);
		strcat(para1, "\n\tend ");
		$$ = para1;
	}
	| T_PARA lvalue T_DE expressao T_ATE expressao passo T_FACA lista_funcionalidades T_FIM_PARA
	{
		char *para2 = (char *) malloc (strlen($2)+strlen($4)+strlen($6)+strlen($7)+strlen($9)+25);
		strcpy(para2, "\n\tfor @");
		strcat(para2, $2);
		strcat(para2, " in ");
		strcat(para2, $4);
		strcat(para2, "..@");
		strcat(para2, $6);
		strcat(para2, "\n\t\t");
		strcat(para2, "@");
		strcat(para2, $2);
		strcat(para2, $7);
		strcat(para2, "\n");
		strcat(para2, $9);
		strcat(para2, "\n\tend ");
		$$ = para2;
	}
	;
passo
	: T_PASSO T_SUBTRACAO T_INT_LIT
	{
		char *passo = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(passo, $2);
		strcat(passo, "=");
		strcat(passo, $3);
		$$ = passo;
	}
	|T_PASSO T_SOMA T_INT_LIT
	{
		char *passo = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(passo, $2);
		strcat(passo, "=");
		strcat(passo, $3);
		$$ = passo;
	}
	;

funcao_imprima:
	T_IMPRIMA T_ABRE_PARENTESES printar T_FECHA_PARENTESES T_PONTO_VIRGULA
	{ 
		char *fprint = (char *) malloc (strlen($3)+8);
		strcpy(fprint, "\n\tputs ");
		strcat(fprint, $3 );
		$$ = fprint;
	}
;

printar: 
	printar T_VIRGULA lista_Variaveis T_VIRGULA printar { 
		char *print1 = (char *) malloc (strlen($1)+strlen($3)+strlen($5)+4);
		strcpy(print1, $1);
		strcat(print1, ",@");
		strcat(print1, $3);
		strcat(print1, ",");
		strcat(print1, $5);
		$$ = print1;
	}
	| printar T_VIRGULA lista_Variaveis  { 
		char *print2 = (char *) malloc (strlen($1)+strlen($3)+3);
		strcpy(print2, $1);
		strcat(print2, ",@");
		strcat(print2, $3);
		$$ = print2;
	}
	| lista_Variaveis T_VIRGULA printar { 
		char *print3 = (char *) malloc (strlen($1)+strlen($3)+3);
		strcpy(print3, "@");
		strcat(print3, $1);
		strcat(print3, ",");
		strcat(print3, $3);
		$$ = print3;
	}
	| lista_Variaveis
	{
		char *print4 = (char *) malloc (strlen($1)+2);
		strcpy(print4, "@");
		strcat(print4, $1);
		$$ = print4;
	}
	| T_PRINTAR
	{
		char *print5 = (char *) malloc (strlen($1)+1);
		strcpy(print5, $1);
		$$ = print5;	
	}
;

funcao_leia: 
	T_LEIA
	{
		char *leia = (char *) malloc (sizeof(char));
		strcpy(leia, "gets ");
		
		$$ = leia;
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
		strcat(exp7, ".to_i");
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
		strcpy(exp14,"@");
		strcat(exp14, $1);
		strcat(exp14, "*@");
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
arqInput = "entrada.gpt";
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
//Liberar espaço de memória utilizado
    return 0;
}
