%{
#include "common.h"
#include "parser.h"
FILE *arq;
%}
 
/* Definições */



NOME_VARIAVEL[a-z][a-z0-9]*
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

"INTEIRO" { 
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
return T_TIPO_INTEIRO;
}

"REAL" { 
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
return T_TIPO_REAL; 
}

"LÓGICO" { 
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
return T_TIPO_LOGICO; 
}
"LITERAL" { 
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
return T_TIPO_LITERAL; 
}
"CARACTERE" { 
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
return T_TIPO_CARACTERE;
}

{NOME_VARIAVEL} {
arq = fopen("teste.rb","a");
fprintf(arq,"%s ", yytext);
fclose(arq);
return T_NOME_VARIAVEL; 
}

{DIGITS} { return T_DIGIT; }
"," { 
arq = fopen("teste.rb","a");
fprintf(arq,",");
fclose(arq);
return T_VIRGULA; 
}
 
{ANY_CHAR} {
	printf("Unexpected character in input: '%c' (ASCII=%d)\n", yytext[0], yytext[0]);
}

