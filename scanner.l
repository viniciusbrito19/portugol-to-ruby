%{
#include "common.h"
#include "parser.h"
%}
 
/* Definições */
STRING [a-z][b-z0-9]*
WHITESPACE [ \n\r\t]+
DIGITS [0-9]+
RECEBER [:][=]
ANY_CHAR .
 
%option case-insensitive
 
%% /* Regras */
 
{WHITESPACE} /* Ignore */ ;
 
"ALGORITMO" { return T_ALGORITMO; }
"IMPRIMA" { return T_IMPRIMA; }
"VARIAVEIS" { return T_VARIAVEIS; }
"FIM" { return T_FIM; }
"SE" { return T_SE; }
"ENTAO" { return T_ENTAO; }
"SENAO" { return T_SENAO; }
"PARA" { return T_PARA; }
"FIM-VARIAVEIS" { return T_FIM_VARIAVEIS; }
"FIM-SE" { return T_FIM_SE; }


{STRING} { return T_STRING; }
{DIGITS} { return T_DIGIT; }
"," { return ','; }
 
{ANY_CHAR} {
	printf("Unexpected character in input: '%c' (ASCII=%d)\n", yytext[0], yytext[0]);
}
