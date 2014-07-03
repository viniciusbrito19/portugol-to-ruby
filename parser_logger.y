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

%locations

%{
char buffer[1000];
char *valorTabSimb;
struct TS *tabSimb = NULL;
int cont1=0,cont2=0;
%}

%start inicio
 
%%

inicio:
	algoritmo {
		geraRelatorioDeErrosSemanticos(tabSimb);
		fflush(stdin);
	}
	;

algoritmo:
	declaracao_algoritmo
	| declaracao_variaveis
	| corpo_programa
	| declaracao_algoritmo declaracao_variaveis {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		$$ = dec;
	}
	| declaracao_algoritmo declaracao_variaveis corpo_programa {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		$$ = dec;
	}
	;

declaracao_algoritmo:
	T_ALGORITMO T_IDENTIFICADOR T_PONTO_VIRGULA {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		$$ = dec;
	}
	;

declaracao_variaveis:
	T_VARIAVEIS declara_Tipo T_FIM_VARIAVEIS {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		$$ = dec;
	}
	;

declara_Tipo:
	lista_Variaveis tipo_Variavel {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		$$ = dec;
	}
	| lista_Variaveis tipo_Variavel declara_Tipo {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		$$ = dec;
	}
	;

lista_Variaveis:
	lista_Variaveis T_VIRGULA variavel {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		tabSimb = incluiNome(tabSimb, $3, @3);
		$$ = dec;
	}
	| variavel {
		tabSimb = incluiNome(tabSimb, $1, @1);
		$$ = $1;
	}
	;

variavel:
	T_IDENTIFICADOR	{
		$$ = $1;
		cont2++;
	}
	|'`' T_IDENTIFICADOR '`' {
		$$ = $1;
		cont2++;
	}
	;
 
tipo_Variavel:
	T_RECEBER tipo_primitivo T_PONTO_VIRGULA {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		$$ = dec;
	}
	;

tipo_primitivo:
	T_TIPO_INTEIRO {
		tabSimb = geraTipos(tabSimb, $1, cont1, (cont2-1));
		cont1=cont2;
		$$ = $1;
	}
	| T_TIPO_REAL {
		tabSimb = geraTipos(tabSimb, $1, cont1, (cont2-1));
		cont1=cont2;
		$$ = $1;
	}
	| T_TIPO_CARACTERE {
		tabSimb = geraTipos(tabSimb, $1, cont1, (cont2-1));
		cont1=cont2;
		$$ = $1;
	}
	| T_TIPO_LITERAL {
		tabSimb = geraTipos(tabSimb, $1, cont1, (cont2-1));
		cont1=cont2;
		$$ = $1;
	}
	| T_TIPO_LOGICO {
		tabSimb = geraTipos(tabSimb, $1, cont1, (cont2-1));
		cont1=cont2;
		$$ = $1;
	}
	;

corpo_programa:
	T_INICIO corpo_lista T_FIM {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		$$ = dec;
	}
	;

corpo_lista:
	corpo_lista lista_funcionalidades {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		$$ = dec;
	}
	|lista_funcionalidades{
		$$ = $1;
	}
	;

lista_funcionalidades:
	atribuicao lista_funcionalidades {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		$$ = dec;
	}
	| atribuicao {
		$$ = $1;
	}
	| retorno T_PONTO_VIRGULA {
		$$ = $1;
	}
	| funcao_se lista_funcionalidades {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		$$ = dec;
	}
	| funcao_se {
		$$ = $1;
	}
	| funcao_enquanto lista_funcionalidades {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		$$ = dec;
	}
	| funcao_enquanto {
		$$ = $1;
	}
	| funcao_para lista_funcionalidades {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		$$ = dec;
	}
	| funcao_para {
		$$ = $1;
	}
	| funcao_imprima lista_funcionalidades {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		$$ = dec;
	}
	| funcao_imprima {
		$$ = $1;
	}
	;

retorno: 
	T_RETORNE expressao {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		$$ = dec;
	}
	| T_RETORNE {
		$$ = $1;
	}
	;

lvalue: 
	T_IDENTIFICADOR
	| T_IDENTIFICADOR T_ABRE_COLCHETES expressao T_FECHA_COLCHETES {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+strlen($4)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		strcat(dec, $4);
		$$ = dec;
	}
	;

atribuicao:
	variavel T_ATRIBUICAO expressao T_PONTO_VIRGULA {
		tabSimb = incluiValor(tabSimb, $1, $3, @1);
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+strlen($4)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		strcat(dec, $4);
		$$ = dec;
	}
	;

funcao_se: 
	T_SE expressao T_ENTAO lista_funcionalidades T_SENAO lista_funcionalidades T_FIM_SE {		
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+strlen($6)+strlen($7)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		strcat(dec, $4);
		strcat(dec, $5);
		strcat(dec, $6);
		strcat(dec, $7);
		$$ = dec;
	}
	| T_SE expressao T_ENTAO lista_funcionalidades T_FIM_SE {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		strcat(dec, $4);
		strcat(dec, $5);
		$$ = dec;
	}
	;

funcao_enquanto:
	T_ENQUANTO expressao T_FACA lista_funcionalidades T_FIM_ENQUANTO {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		strcat(dec, $4);
		strcat(dec, $5);
		$$ = dec;
	}
	;

funcao_para:
	T_PARA lvalue T_DE expressao T_ATE expressao T_FACA lista_funcionalidades T_FIM_PARA {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+strlen($6)+strlen($7)+strlen($8)+strlen($9)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		strcat(dec, $4);
		strcat(dec, $5);
		strcat(dec, $6);
		strcat(dec, $7);
		strcat(dec, $8);
		strcat(dec, $9);
		$$ = dec;
	}
	| T_PARA lvalue T_DE expressao T_ATE expressao passo T_FACA lista_funcionalidades T_FIM_PARA {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+strlen($6)+strlen($7)+strlen($8)+strlen($9)+strlen($10)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		strcat(dec, $4);
		strcat(dec, $5);
		strcat(dec, $6);
		strcat(dec, $7);
		strcat(dec, $8);
		strcat(dec, $9);
		strcat(dec, $10);
		$$ = dec;
	}
	;

passo
	: T_PASSO T_SUBTRACAO T_INT_LIT {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		$$ = dec;
	}
	|T_PASSO T_SOMA T_INT_LIT {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		$$ = dec;
	}
	;

funcao_imprima:
	T_IMPRIMA T_ABRE_PARENTESES printar T_FECHA_PARENTESES T_PONTO_VIRGULA { 
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		strcat(dec, $4);
		strcat(dec, $5);
		$$ = dec;
	}
	;

printar: 
	printar T_VIRGULA variavel T_VIRGULA printar { 
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		strcat(dec, $4);
		strcat(dec, $5);
		$$ = dec;
	}
	| printar T_VIRGULA variavel  { 
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		$$ = dec;
	}
	| variavel T_VIRGULA printar { 
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, $2);
		strcat(dec, $3);
		$$ = dec;
	}
	| variavel {
		$$ = $1;
	}
	| T_PRINTAR {
		$$ = $1;
	}
	;

funcao_leia: 
	T_LEIA {
		$$ = $1;
	}
	;
expressao:
	expressao T_OR expressao {		
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+4);
		strcpy(dec, $1);
		strcat(dec, " LOG ");
		strcat(dec, $3);
		$$ = dec;
	}
	| expressao T_OR2 expressao {		
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+4);
		strcpy(dec, $1);
		strcat(dec, " LOG ");
		strcat(dec, $3);
		$$ = dec;
	}
	| expressao T_AND expressao {		
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+4);
		strcpy(dec, $1);
		strcat(dec, " LOG ");
		strcat(dec, $3);
		$$ = dec;
	}
	| expressao T_AND2 expressao {		
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+4);
		strcpy(dec, $1);
		strcat(dec, " LOG ");
		strcat(dec, $3);
		$$ = dec;
	}
	| expressao T_IGUAL expressao {		
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+4);
		strcpy(dec, $1);
		strcat(dec, " LOG ");
		strcat(dec, $3);
		$$ = dec;
	}
	| expressao T_DIFERENTE expressao {
		char *dec = (char *) malloc (7);
		strcpy(dec, "LOGICO");
		$$ = dec;
	}
	| expressao T_MAIOR expressao {		
		char *dec = (char *) malloc (7);
		strcpy(dec, "LOGICO");
		$$ = dec;
	}
	| expressao T_MAIOR_IGUAL expressao {		
		char *dec = (char *) malloc (7);
		strcpy(dec, "LOGICO");
		$$ = dec;
	}
	| expressao T_MENOR expressao {		
		char *dec = (char *) malloc (7);
		strcpy(dec, "LOGICO");
		$$ = dec;
	}
	| expressao T_MENOR_IGUAL expressao {		
		char *dec = (char *) malloc (7);
		strcpy(dec, "LOGICO");
		$$ = dec;
	}
	| expressao T_SOMA expressao {		
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, " ");
		strcat(dec, $3);
		$$ = dec;
	}
	| expressao T_SUBTRACAO expressao {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, " ");
		strcat(dec, $3);
		$$ = dec;
	}
	| expressao T_DIVISAO expressao {
		char *dec = (char *) malloc (5);
		strcpy(dec, "REAL");
		$$ = dec;
	}
	| expressao T_MULTIPLICACAO expressao {
		char *dec = (char *) malloc (strlen($1)+strlen($2)+strlen($3)+1);
		strcpy(dec, $1);
		strcat(dec, " ");
		strcat(dec, $3);
		$$ = dec;
	}
	| expressao T_PORCENTAGEM expressao {
		char *dec = (char *) malloc (8);
		strcpy(dec, "INTEIRO");
		$$ = dec;
	}
	| T_SOMA termo {
		$$ = $2;
	}
	| T_SUBTRACAO termo {
		$$ = $2;
	}
	| termo {
		$$ = $1;
	}
	;

termo:
	lvalue
	| literal
	| funcao_leia {
		char *dec = (char *) malloc (8);
		strcpy(dec, "OK");
		$$ = dec;
	}
	| T_ABRE_PARENTESES expressao T_FECHA_PARENTESES{
		$$ = $2;
	}
	;

literal: 
	T_DEC_LIT {
		char *dec = (char *) malloc (8);
		strcpy(dec, "INTEIRO");
		$$ = dec;	
	}
	| T_INT_LIT {
		char *dec = (char *) malloc (8);
		strcpy(dec, "INTEIRO");
		$$ = dec;
	}
	| T_REAL_LIT {
		char *dec = (char *) malloc (5);
		strcpy(dec, "REAL");
		$$ = dec;
	}
	| T_PRINTAR {
		char *dec = NULL;
		dec = verificaString($1);
		$$ = dec;
	}
	;

%%
 
void yyerror(const char* errmsg)
{
	printf("\n***[%d] Erro: %s [%s]\n", yylineno, errmsg, yytext);
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

fflush(yyin);
//Liberar espaço de memória utilizado
    return 0;
}
