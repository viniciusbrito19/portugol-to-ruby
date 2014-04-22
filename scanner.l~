%{
#include "common.h"
#include "parser.h"
FILE *arq;
%}
 
/* Definições */

DEC_LIT [0-9]+
OCTAL_LIT '0' ('c'|'C') [0-8]+
HEX_LIT '0' ('x'|'X') [0-9a-fA-F]+
BIN_LIT '0' ('b'|'B') [01]+
REAL_LIT {DEC_LIT}+("."{DEC_LIT})+
INT_LIT {OCTAL_LIT} | {HEX_LIT} | {BIN_LIT} | {DEC_LIT}
IDENTIFICADOR [a-z][a-z0-9]*
WHITESPACE [ \n\r\t]+
 
%%
 
{WHITESPACE} /* Ignore */ ;
{IDENTIFICADOR} { return T_IDENTIFICADOR; }
{REAL_LIT} { return T_REAL_LIT; }
{INT_LIT} { return T_INT_LIT; }

%%

yywrap () {
return 0;
}

