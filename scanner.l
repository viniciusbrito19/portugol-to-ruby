%{
#include "common.h"
#include "parser.h"
%}
 
/* Definições */

/*STRING [a-z][b-z0-9]* */

NOME_VARIAVEL [a-zA-Z_] [a-zA-Z0-9_]*
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
"INTEIRO" { return T_TIPO_INTEIRO; }
"REAL" { return T_TIPO_REAL; }
"LÓGICO" { return T_TIPO_LOGICO; }
"LITERAL" { return T_TIPO_LITERAL; }
"CARACTERE" { return T_TIPO_CARACTERE; }


/*{STRING} { return T_STRING; }*/
NOME_VARIAVEL { return T_NOME_VARIAVEL }
{DIGITS} { return T_DIGIT; }
"," { return ','; }
 
{ANY_CHAR} {
	printf("Unexpected character in input: '%c' (ASCII=%d)\n", yytext[0], yytext[0]);
}