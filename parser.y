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
%token T_ABRE_PARENTESES 
%token T_ALGORITMO
%token T_AND
%token T_CONDICAO
%token T_DIFERENTE
%token T_DIGIT
%token T_DIVISAO
%token T_ENTAO
%token T_FECHA_PARENTESES
%token T_FIM
%token T_FIM_SE
%token T_FIM_VARIAVEIS
%token T_IGUAL
%token T_IMPRIMA
%token T_MAIOR_IGUAL
%token T_MENOR_IGUAL
%token T_MULTIPLICACAO
%token T_NOME_VARIAVEL
%token T_OR
%token T_PARA
%token T_PONTO_VIRGULA
%token T_RECEBER
%token T_SE
%token T_SENAO
%token T_SOMA
%token T_SUBTRACAO
%token T_TIPO_INTEIRO
%token T_TIPO_CARACTERE
%token T_TIPO_REAL
%token T_TIPO_LOGICO
%token T_TIPO_LITERAL
%token T_VIRGULA
%token T_VARIAVEIS


%left T_SOMA T_SUBTRACAO
%left T_MULTIPLICACAO T_DIVISAO
%left NEG

//RT-AN66R(U)
//RT-AC66
%{
char str1[1000];
char buffer[1000];
extern char* yytext;
%}

%error-verbose
 
%%


stmt:
		stmt_meio	
;

stmt_inicio:
		stmt_declaracao
;

stmt_meio:
		stmt_se
;

stmt_declaracao:

		T_VARIAVEIS Declara_Tipo T_FIM_VARIAVEIS
{
arq = fopen("teste.rb","a");
fprintf(arq,"def \n %s \n end", str1);
fclose(arq);
}
;

Declara_Tipo:
		Lista_Variaveis Tipo_Variavel
	|	Lista_Variaveis Tipo_Variavel Declara_Tipo
;

Lista_Variaveis:
		Variavel
{
strcpy(buffer, yytext);
strcat(str1, buffer);
}
	|	Lista_Variaveis T_VIRGULA Variavel 
{
strcpy(buffer, yytext);
strcat(str1, buffer);
}
;

Variavel:
		T_NOME_VARIAVEL

	|	'`' T_NOME_VARIAVEL '`'
;
 
Tipo_Variavel:
		T_RECEBER T_TIPO_INTEIRO T_PONTO_VIRGULA

	| 	T_RECEBER T_TIPO_CARACTERE T_PONTO_VIRGULA

	| 	T_RECEBER T_TIPO_REAL T_PONTO_VIRGULA

	| 	T_RECEBER T_TIPO_LOGICO T_PONTO_VIRGULA

	| 	T_RECEBER T_TIPO_LITERAL T_PONTO_VIRGULA
;


stmt_se:
		T_SE Rec_Se T_ENTAO Rec_Entao_Senao T_FIM_SE
{
printf("Funcionou!");
/*arq = fopen("teste.rb","a");
fprintf(arq,"if ( %s ) then\n", str1);
fclose(arq);*/
}

	
	|	T_SE Rec_Se T_ENTAO Rec_Entao_Senao T_SENAO Rec_Entao_Senao T_FIM_SE
{
printf("Funcionou");
/*arq = fopen("teste.rb","a");
fprintf(arq,"if ( %s ) then\n", str1);
fclose(arq);*/
}
;

Rec_Entao_Senao:
		stmt_se
	|	Expressao_Mat 	

;

Expressao_Mat:
		Variavel T_IGUAL Variavel T_PONTO_VIRGULA
	
	|	Variavel T_IGUAL Expressao_Num T_PONTO_VIRGULA

	|	Expressao_Num T_IGUAL Variavel T_PONTO_VIRGULA
;


Expressao_Num:
		T_DIGIT

   	|	Expressao_Num T_SOMA Expressao_Num

   	|	Expressao_Num T_SUBTRACAO Expressao_Num
	
   	|	Expressao_Num T_MULTIPLICACAO Expressao_Num
		
   	| 	Expressao_Num T_DIVISAO Expressao_Num
	
	| 	T_SUBTRACAO Expressao_Num %prec NEG
   	
	| 	T_ABRE_PARENTESES Expressao_Num T_FECHA_PARENTESES
;

Rec_Se:
		Condicao_Se

	|	Condicao_Se T_AND Condicao_Se

	|	Condicao_Se T_OR Condicao_Se
;	

Condicao_Se:
		Variavel T_CONDICAO T_DIGIT
{
strcpy(buffer, yytext);
strcat(str1, buffer);
}
	|	Variavel T_MAIOR_IGUAL T_DIGIT
{
strcpy(buffer, yytext);
strcat(str1, buffer);
}
	|	Variavel T_MENOR_IGUAL T_DIGIT
{
strcpy(buffer, yytext);
strcat(str1, buffer);
}
	|	Variavel T_IGUAL T_DIGIT
{
strcpy(buffer, yytext);
strcat(str1, buffer);
}
	|	Variavel T_DIFERENTE T_DIGIT
{
strcpy(buffer, yytext);
strcat(str1, buffer);
}

;
	

/*
Fim:
		T_FIM
{
arq = fopen("teste.rb","a");
fprintf(arq,"end");
fclose(arq);
}
;


Se:
		T_SE
{
arq = fopen("teste.rb","a");
fprintf(arq,"if ");
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
