%{
#include "common.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "funcao.c"
FILE *arq;
%}

//%token T_STRING 
%token T_ALGORITMO
%token T_VARIAVEIS
%token T_IMPRIMA
%token T_NOME_VARIAVEL
%token T_DIGIT
%token T_FIM
%token T_SE
%token T_ENTAO
%token T_SENAO
%token T_PARA
%token T_FIM_SE
%token T_FIM_VARIAVEIS
%token T_TIPO_INTEIRO
%token T_TIPO_CARACTERE
%token T_TIPO_REAL
%token T_TIPO_LOGICO
%token T_TIPO_LITERAL
//RT-AN66R(U)
//RT-AC66
%{
char str1[1000];
%}

%error-verbose
 
%%



stmt:
	Declaracao_Variaveis | Variaveis | Tipo_Variaveis | Imprima | Se | Entao | Senao | Fim_Se | Para | Fim |
;

Declaracao_Variaveis:
	T_NOME_VARIAVEL ("," T_NOME_VARIAVEL)* ":" (Tipo_Variavel)

{
arq = fopen("teste.rb","a");
fprintf(arq," \n");
fclose(arq);
}stmt
;


Tipo_Variavel:
	T_TIPO_INTEIRO
{
arq = fopen("teste.rb","a");
fprintf(arq,"def %s \n", T_TIPO_INTEIRO);
fclose(arq);
} 
	| T_TIPO_CARACTERE 
	| T_TIPO_REAL 
	| T_TIPO_LOGICO 
	| T_TIPO_LITERAL
{
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
}Declaracao_Variaveis
;

Fim:
		T_FIM
{
arq = fopen("teste.rb","a");
fprintf(arq,"end");
fclose(arq);
}stmt
;

Fim_Se:
		T_FIM_SE
{
arq = fopen("teste.rb","a");
fprintf(arq,"end \n");
fclose(arq);
}stmt
;

Variaveis:
		T_VARIAVEIS
{
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
}stmt
;

field_list:
		field
	|	field_list ',' field
;

field:
		T_STRING
	|	'`' T_STRING '`'
;
 
Imprima:
		T_IMPRIMA
{
arq = fopen("teste.rb","a");
fprintf(arq,"puts \n");
fclose(arq);
//zeroChar(str1);
}stmt
;

Se:
		T_SE
{
arq = fopen("teste.rb","a");
fprintf(arq,"if \n");
fclose(arq);
//zeroChar(str1);
}stmt
;

Entao:
		T_ENTAO
{
arq = fopen("teste.rb","a");
fprintf(arq,"then \n");
fclose(arq);
//zeroChar(str1);
}stmt
;

Senao:
		T_SENAO
{
arq = fopen("teste.rb","a");
fprintf(arq,"else \n");
fclose(arq);
}stmt
;

Para:
		T_PARA
{
arq = fopen("teste.rb","a");
fprintf(arq,"for \n");
fclose(arq);
//zeroChar(str1);
}stmt

%%
 
void yyerror(const char* errmsg)
{
	printf("\n*** Erro: %s\n", errmsg);
}
 
int yywrap(void) { return 1; }
 
int main(int argc, char** argv)
{
     yyparse();

     return 0;
}
/*int main(void) {

	arq = fopen("Documentos/Compiladores/exemplo02/teste.txt","w");
     yyparse();
    fflush(arq);
fclose(arq);
}*/
