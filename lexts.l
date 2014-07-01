%{
#include <stdio.h>
#include <string.h>
#include "common.h"
#include "parts.h"
#include <stdlib.h>
#define YY_DECL extern int yylex()
%}
 
/* Definições */
DIGITO [0-9]
DEC_LIT {DIGITO}+
INT_LIT ("+"|"-"){DEC_LIT}
REAL_LIT {DEC_LIT}+("."{DEC_LIT})
IDENTIFICADOR [a-zA-Z_][a-zA-Z0-9_]*
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
"ALGORITMO" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_ALGORITMO;
	}
"IMPRIMA" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_IMPRIMA;
}
"VARIAVEIS" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_VARIAVEIS;
}
"INICIO" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_INICIO;
}
"FIM" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_FIM;
}
"SE" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_SE;
}
"ENTAO" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_ENTAO;
}
"SENAO" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_SENAO;
}
"ENQUANTO" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_ENQUANTO;
}
"FIM-ENQUANTO" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_FIM_ENQUANTO;
}
"PARA" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);return T_PARA;
}
"DE" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_DE;
}
"ATE" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_ATE;
}
"FACA" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_FACA;
}
"FIM-PARA" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_FIM_PARA;
}
"FIM-VARIAVEIS" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_FIM_VARIAVEIS;
}
"FIM-SE" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_FIM_SE;
}
"INTEIRO" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_TIPO_INTEIRO;
}
"REAL" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_TIPO_REAL;
}
"LOGICO" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_TIPO_LOGICO;
}
"LITERAL" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_TIPO_LITERAL;
}
"CARACTERE" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_TIPO_CARACTERE;
}
"RETORNE" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_RETORNE;
}
"LEIA()" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_LEIA;
}
"PASSO" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_PASSO;
}
"," {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext); 
	return T_VIRGULA;
}
{PONTO_VIRGULA} {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_PONTO_VIRGULA;
}
">=" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_MAIOR_IGUAL;
}
"<=" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_MENOR_IGUAL;
}
"<" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_MENOR;
}
">" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_MAIOR;
}
"e" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_AND;
}
"&&" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_AND2;
}
"ou" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_OR;
}
"||" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_OR2;
}
"<>" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_DIFERENTE;
}
":=" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_ATRIBUICAO;
}
"%" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_PORCENTAGEM;
}
"+" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_SOMA;
}
"-" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_SUBTRACAO;
}
"=" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_IGUAL;
}
"*" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_MULTIPLICACAO;
}
"/" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_DIVISAO;
}
{ABRE_PARENTESES} {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_ABRE_PARENTESES;
}
{FECHA_PARENTESES} {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_FECHA_PARENTESES;
}
"[" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_ABRE_COLCHETES;
}
"]" {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_FECHA_COLCHETES;
}
{IDENTIFICADOR} {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_IDENTIFICADOR;
}
{REAL_LIT} {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_REAL_LIT;
}
{INT_LIT} {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_INT_LIT;
}
{DEC_LIT} {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_DEC_LIT;
}
{RECEBER} {
	yylval = (char*) malloc( sizeof(char) ); 
	strcpy(yylval, yytext);
	return T_RECEBER;
}
{PRINTAR} {
	yylval = (char*) malloc( strlen(yylval)+200 ); 
	strcpy(yylval, yytext);
	return T_PRINTAR;
}
%%
