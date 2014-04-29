%{
#include "common.h"
#include "parser.h"
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


%option case-insensitive

%%
{WHITESPACE} /* Ignore */ ;
"ALGORITMO" { return T_ALGORITMO; }
"IMPRIMA" { return T_IMPRIMA; }
"VARIAVEIS" { return T_VARIAVEIS; }
"INICIO" {return T_INICIO; }
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

"," { return T_VIRGULA; }
";" { return T_PONTO_VIRGULA; }
">=" { return T_MAIOR_IGUAL; }
"<=" { return T_MENOR_IGUAL; }
"<" { return T_MENOR; }
">" { return T_MAIOR; }
"e" { return T_AND; }
"&&" { return T_AND2; }
"ou" { return T_OR; }
"||" { return T_OR2; }
"<>" { return T_DIFERENTE; }
":=" { return T_ATRIBUICAO; }
"%" { return T_PORCENTAGEM; }

"+" { return T_SOMA; }
"-" { return T_SUBTRACAO; }
"=" { return T_IGUAL; }
"*" { return T_MULTIPLICACAO; }
"/" { return T_DIVISAO; }
"(" { return T_ABRE_PARENTESES; }
")" { return T_FECHA_PARENTESES; }
"[" { return T_ABRE_COLCHETES; }
"]" { return T_FECHA_COLCHETES; }

{IDENTIFICADOR} { return T_IDENTIFICADOR; }
{REAL_LIT} { return T_REAL_LIT; }
{INT_LIT} { return T_INT_LIT; }
{DEC_LIT} {return T_DEC_LIT; }
{RECEBER} { return T_RECEBER; }
{STRING} { return T_STRING; }

%%

yywrap () {
return 0;
}

