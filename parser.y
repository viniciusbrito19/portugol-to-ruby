%{
#include "common.h"
#include "parser.h"
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
%token T_VIRGULA
//RT-AN66R(U)
//RT-AC66
//%{
//char str1[1000];
//extern char* yytext;
//%}

%error-verbose
 
%%


stmt:
	total
;
 
Lista_Variaveis:
		Variavel
	|	Lista_Variaveis T_VIRGULA Variavel
;

Variavel:
		T_NOME_VARIAVEL
	|	'`' T_NOME_VARIAVEL '`'
;
 
total:
		T_VARIAVEIS Lista_Variaveis T_TIPO_REAL 
;

/*
Tipo_Variavel:
	T_TIPO_INTEIRO
{
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
}

	| T_TIPO_CARACTERE
{
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
}

	| T_TIPO_REAL 
{
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
}

	| T_TIPO_LOGICO 
{
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
} 

	| T_TIPO_LITERAL
{
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
}
;

Fim:
		T_FIM
{
arq = fopen("teste.rb","a");
fprintf(arq,"end");
fclose(arq);
}
;

Fim_Se:
		T_FIM_SE
{
arq = fopen("teste.rb","a");
fprintf(arq,"end \n");
fclose(arq);
}
;

Variaveis:
		T_VARIAVEIS
{
arq = fopen("teste.rb","a");
fprintf(arq,"def \n");
fclose(arq);
}
;

//field_list:
//		field
//	|	field_list ',' field
//;

//field:
//		T_STRING
//	|	'`' T_STRING '`'
//;
 
Imprima:
		T_IMPRIMA
{
arq = fopen("teste.rb","a");
fprintf(arq,"puts \n");
fclose(arq);
//zeroChar(str1);
}
;

Se:
		T_SE
{
arq = fopen("teste.rb","a");
fprintf(arq,"if \n");
fclose(arq);
//zeroChar(str1);
}
;

Entao:
		T_ENTAO
{
arq = fopen("teste.rb","a");
fprintf(arq,"then \n");
fclose(arq);
//zeroChar(str1);
}
;

Senao:
		T_SENAO
{
arq = fopen("teste.rb","a");
fprintf(arq,"else \n");
fclose(arq);
}
;

Para:
		T_PARA
{
arq = fopen("teste.rb","a");
fprintf(arq,"for \n");
fclose(arq);
//zeroChar(str1);
}
*/
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
