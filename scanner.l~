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
String {LETRA}|{DIGITOS}|{PONTUACAO}|{ESPACO}|{ASPAS}
WHITESPACE [ \n\r\t]+
 
%%
 
{WHITESPACE} /* Ignore */ ;
{IDENTIFICADOR} { return T_IDENTIFICADOR; }
{REAL_LIT} { return T_REAL_LIT; }
{INT_LIT} { return T_INT_LIT; }
{String} { return String; }

%%

yywrap () {
return 0;
}

