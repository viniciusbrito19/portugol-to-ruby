%{
#include <stdio.h>
#include <string.h>
#include "common.h"
#include "parser.h"
#include <stdlib.h>
#define YY_DECL extern int yylex()
%}
 
/* Definições */

DEC_LIT [0-9]+
REAL_LIT {DEC_LIT}+("."{DEC_LIT})+
digit [0-9]
INT_LIT {digit}+
IDENTIFICADOR [a-zA-Z_][a-zA-Z0-9_]*
DIGITOS [0-9]+
LETRA [A-Za-záÉçãêü\)\(@\{\}/]+
ESPACO [" "]
PONTUACAO [–.:,-\<=\\>\>\\n\#]+
RECEBER [:]?
WHITESPACE [ \n\r\t]+
PRINTAR \"[a-zA-Z0-9].*\"
PONTO_VIRGULA [;]*
ABRE_PARENTESES [(]*
FECHA_PARENTESES [)]*

%option case-insensitive noyywrap

%%
{WHITESPACE} /* Ignore */ ;
"ALGORITMO" { return T_ALGORITMO; }
"IMPRIMA" { return T_IMPRIMA; }
"VARIAVEIS" { return T_VARIAVEIS; }
"INICIO" { return T_INICIO; }
"FIM" { return T_FIM; }
"SE" { return T_SE; }
"ENTAO" { return T_ENTAO; }
"SENAO" { return T_SENAO; }
"ENQUANTO" { return T_ENQUANTO; }
"FIM-ENQUANTO" { return T_FIM_ENQUANTO; }
"PARA" { return T_PARA; }
"DE" { return T_DE; }
"ATE" { return T_ATE; }
"FACA" { return T_FACA; }
"FIM-PARA" { return T_FIM_PARA; }
"FIM-VARIAVEIS" { return T_FIM_VARIAVEIS; }
"FIM-SE" { return T_FIM_SE; }
"INTEIRO" { return T_TIPO_INTEIRO; }
"REAL" { return T_TIPO_REAL; }
"LOGICO" { return T_TIPO_LOGICO; }
"LITERAL" { return T_TIPO_LITERAL; }
"CARACTERE" { return T_TIPO_CARACTERE; }
"RETORNE" { return T_RETORNE; }
"LEIA()" { return T_LEIA; }
"PASSO" { return T_PASSO; }

"," { return T_VIRGULA; }
{PONTO_VIRGULA} { return T_PONTO_VIRGULA; }
">=" { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_MAIOR_IGUAL; }
"<=" { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_MENOR_IGUAL; }
"<" { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_MENOR; }
">" { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_MAIOR; }
"e" { return T_AND; }
"&&" { return T_AND2; }
"ou" { return T_OR; }
"||" { return T_OR2; }
"<>" { return T_DIFERENTE; }
":=" { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_ATRIBUICAO; }
"%" { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_PORCENTAGEM; }

"+" { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_SOMA; }
"-" { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_SUBTRACAO; }
"=" { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_IGUAL; }
"*" { return T_MULTIPLICACAO; }
"/" { return T_DIVISAO; }
{ABRE_PARENTESES} { return T_ABRE_PARENTESES; }
{FECHA_PARENTESES} { return T_FECHA_PARENTESES; }
"[" { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_ABRE_COLCHETES; }
"]" { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_FECHA_COLCHETES; }

{IDENTIFICADOR} { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_IDENTIFICADOR; }
{REAL_LIT} { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_REAL_LIT; }
{INT_LIT} { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_INT_LIT; }
{DEC_LIT} { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_DEC_LIT; }
{RECEBER} { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_RECEBER; }
{PRINTAR} { 
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_PRINTAR; }

%%
