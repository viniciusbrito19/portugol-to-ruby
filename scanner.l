%{
#include <stdio.h>
#include <string.h>
#include "common.h"
#include "parser.h"
#define YY_DECL extern int yylex()
FILE *arq;
%}
 
/* Definições */

DEC_LIT [0-9]+
REAL_LIT {DEC_LIT}+("."{DEC_LIT})+
digit [0-9]
INT_LIT {digit}+
IDENTIFICADOR [a-zA-Z_][a-zA-Z0-9_]*
DIGITOS [0-9]+
LETRA [A-Za-záÉçãêü\)\(@\{\}/]+
ASPAS [\“\”\’\']+
ESPACO [" "]
PONTUACAO [–.:,-\<=\\>\>\\n\#]+
STRING {LETRA}|{DIGITOS}|{PONTUACAO}|{ESPACO}|{ASPAS}
RECEBER [:]?
WHITESPACE [ \n\r\t]+
PRINTAR \"{STRING}*\"
PONTO_VIRGULA [;]*
ABRE_PARENTESES [(]*
FECHA_PARENTESES [)]*

%option case-insensitive

%%
{WHITESPACE} /* Ignore */ ;
"ALGORITMO" { yylval.strval = strdup(yytext); return T_ALGORITMO; }
"IMPRIMA" { yylval.strval = strdup(yytext); return T_IMPRIMA; }
"VARIAVEIS" { yylval.strval = strdup(yytext); return T_VARIAVEIS; }
"INICIO" { yylval.strval = strdup(yytext); return T_INICIO; }
"FIM" { yylval.strval = strdup(yytext); return T_FIM; }
"SE" { yylval.strval = strdup(yytext); return T_SE; }
"ENTAO" { yylval.strval = strdup(yytext); return T_ENTAO; }
"SENAO" { yylval.strval = strdup(yytext); return T_SENAO; }
"ENQUANTO" { yylval.strval = strdup(yytext); return T_ENQUANTO; }
"FIM-ENQUANTO" { yylval.strval = strdup(yytext); return T_FIM_ENQUANTO; }
"PARA" { yylval.strval = strdup(yytext); return T_PARA; }
"DE" { yylval.strval = strdup(yytext); return T_DE; }
"ATE" { yylval.strval = strdup(yytext); return T_ATE; }
"FACA" { yylval.strval = strdup(yytext); return T_FACA; }
"FIM-PARA" { yylval.strval = strdup(yytext); return T_FIM_PARA; }
"FIM-VARIAVEIS" { yylval.strval = strdup(yytext); return T_FIM_VARIAVEIS; }
"FIM-SE" { yylval.strval = strdup(yytext); return T_FIM_SE; }
"INTEIRO" { yylval.strval = strdup(yytext); return T_TIPO_INTEIRO; }
"REAL" { yylval.strval = strdup(yytext); return T_TIPO_REAL; }
"LOGICO" { yylval.strval = strdup(yytext); return T_TIPO_LOGICO; }
"LITERAL" { yylval.strval = strdup(yytext); return T_TIPO_LITERAL; }
"CARACTERE" { yylval.strval = strdup(yytext); return T_TIPO_CARACTERE; }
"RETORNE" { yylval.strval = strdup(yytext); return T_RETORNE; }
"LEIA()" { yylval.strval = strdup(yytext); return T_LEIA; }

"," { yylval.strval = strdup(yytext); return T_VIRGULA; }
{PONTO_VIRGULA} { yylval.strval = strdup(yytext); return T_PONTO_VIRGULA; }
">=" { yylval.strval = strdup(yytext); return T_MAIOR_IGUAL; }
"<=" { yylval.strval = strdup(yytext); return T_MENOR_IGUAL; }
"<" { yylval.strval = strdup(yytext); return T_MENOR; }
">" { yylval.strval = strdup(yytext); return T_MAIOR; }
"e" { yylval.strval = strdup(yytext); return T_AND; }
"&&" { yylval.strval = strdup(yytext); return T_AND2; }
"ou" { yylval.strval = strdup(yytext); return T_OR; }
"||" { yylval.strval = strdup(yytext); return T_OR2; }
"<>" { yylval.strval = strdup(yytext); return T_DIFERENTE; }
":=" { yylval.strval = strdup(yytext); return T_ATRIBUICAO; }
"%" { yylval.strval = strdup(yytext); return T_PORCENTAGEM; }

"+" { yylval.strval = strdup(yytext); return T_SOMA; }
"-" { yylval.strval = strdup(yytext); return T_SUBTRACAO; }
"=" { yylval.strval = strdup(yytext); return T_IGUAL; }
"*" { yylval.strval = strdup(yytext); return T_MULTIPLICACAO; }
"/" { yylval.strval = strdup(yytext); return T_DIVISAO; }
{ABRE_PARENTESES} { yylval.strval = strdup(yytext); return T_ABRE_PARENTESES; }
{FECHA_PARENTESES} { yylval.strval = strdup(yytext); return T_FECHA_PARENTESES; }
"[" { yylval.strval = strdup(yytext); return T_ABRE_COLCHETES; }
"]" { yylval.strval = strdup(yytext); return T_FECHA_COLCHETES; }

{IDENTIFICADOR} { yylval.strval = strdup(yytext); return T_IDENTIFICADOR; }
{REAL_LIT} { yylval.strval = strdup(yytext); return T_REAL_LIT; }
{INT_LIT} { yylval.strval = strdup(yytext); return T_INT_LIT; }
{DEC_LIT} { yylval.strval = strdup(yytext); return T_DEC_LIT; }
{RECEBER} { yylval.strval = strdup(yytext); return T_RECEBER; }
{PRINTAR} { yylval.strval = strdup(yytext); return T_PRINTAR; }

%%

yywrap () {
return 0;
}

