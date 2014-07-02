// Biblioteca para Tratamento da Lista da Tabela de Simbolos
#include<stdio.h>
#include<string.h>
#include "parts.h"

// Struct
struct TS
{
	char *nome;
	char *tipo;
	int valor;
	int escopo;
	struct TS *Prox;
	struct YYLTYPE local;
	char *erro;
};

// Retorna o primeiro no econtrado com o mesmo nome
struct TS *pesquisa(struct TS *pLista, char *n)
{
	struct TS *pAux;
	pAux = pLista;
	while(strcmp(pAux->nome,n)!=0)
	{
		pAux = pAux->Prox;
		if(pAux==NULL)
			break;
	}
	return pAux;
}

int pesquisaETrata(struct TS *pLista, char *nome, char *tipo)
{
	int seIncorreto = 0;
	struct TS *pAux = NULL;
	pAux = pesquisa(pLista,nome);
	if(pAux==NULL)
		seIncorreto += 100000;
	else
	{
		if((strcmp(pAux->tipo,tipo)==0)&&(pAux->valor==0)){}
		else
			seIncorreto += 1000000;
	}
	return seIncorreto;
}

int naoParametrico(char *tipo)
{
	if((strcmp(tipo,"REAL")!=0)
		&&(strcmp(tipo,"INTEIRO")!=0)
		&&(strcmp(tipo,"OK")!=0)
		&&(strcmp(tipo,"LOGICO")!=0)
		&&(strcmp(tipo,"LOG")!=0)
		&&(strcmp(tipo,"LITERAL")!=0)
		&&(strcmp(tipo,"CARACTERE")!=0))
		return 1;
	return 0;
}

int comparaReal(struct TS *pLista, char *valor)
{
	char *vTratado = NULL;
	char *ref = (char*) malloc(sizeof(5));
	strcpy(ref,"REAL");
	int seIncorreto = 0;
	vTratado = strtok(valor, " ");
	while(vTratado!=NULL)
	{
		if(naoParametrico(vTratado)==1)
			seIncorreto += pesquisaETrata(pLista,vTratado,ref);
		if((strcmp(vTratado,"REAL")==0)||(strcmp(vTratado,"INTEIRO")==0)||(strcmp(vTratado,"OK")==0)){}
		else if((strcmp(vTratado,"LOGICO")==0)||(strcmp(vTratado,"LOG")==0))
			seIncorreto += 100;
		else if(strcmp(vTratado,"LITERAL")==0)
			seIncorreto += 1000;
		else if(strcmp(vTratado,"CARACTERE")==0)
			seIncorreto += 10000;
		vTratado = strtok(NULL, " ");
	}
	return seIncorreto;
}

int comparaInteiro(struct TS *pLista, char *valor)
{
	char *vTratado = NULL;
	char *ref = (char*) malloc(sizeof(8));
	strcpy(ref,"INTEIRO");
	int seIncorreto = 0;
	vTratado = strtok(valor, " ");
	while(vTratado!=NULL)
	{
		if(naoParametrico(vTratado)==1)
			seIncorreto += pesquisaETrata(pLista,vTratado,ref);		
		if((strcmp(vTratado,"INTEIRO")==0)||(strcmp(vTratado,"OK")==0)){}
		else if(strcmp(vTratado,"REAL")==0)
			seIncorreto += 1;
		else if((strcmp(vTratado,"LOGICO")==0)||(strcmp(vTratado,"LOG")==0))
			seIncorreto += 100;
		else if(strcmp(vTratado,"LITERAL")==0)
			seIncorreto += 1000;
		else if(strcmp(vTratado,"CARACTERE")==0)
			seIncorreto += 10000;
		vTratado = strtok(NULL, " ");
	}
	return seIncorreto;
}

int comparaLogico(struct TS *pLista, char *valor)
{
	char *vTratado = NULL;
	char *ref = (char*) malloc(sizeof(7));
	strcpy(ref,"LOGICO");
	int seIncorreto = 0;
	vTratado = strtok(valor, " ");
	while(vTratado!=NULL)
	{
		if(naoParametrico(vTratado)==1)
			seIncorreto += pesquisaETrata(pLista,vTratado,ref);
		if((strcmp(vTratado,"LOGICO")==0)||(strcmp(vTratado,"OK")==0))
		{
			seIncorreto = 0;
			break;
		}
		else if(strcmp(vTratado,"REAL")==0)
			seIncorreto += 1;
		else if(strcmp(vTratado,"INTEIRO")==0)
			seIncorreto += 10;
		else if(strcmp(vTratado,"LOG")==0)
			seIncorreto += 100;
		else if(strcmp(vTratado,"LITERAL")==0)
			seIncorreto += 1000;
		else if(strcmp(vTratado,"CARACTERE")==0)
			seIncorreto += 10000;
		vTratado = strtok(NULL, " ");
	}
	return seIncorreto;
}

int comparaLiteral(struct TS *pLista, char *valor)
{
	char *vTratado = NULL;
	char *ref = (char*) malloc(sizeof(8));
	strcpy(ref,"LITERAL");
	int seIncorreto = 0;
	vTratado = strtok(valor, " ");
	while(vTratado!=NULL)
	{
		if(naoParametrico(vTratado)==1)
			seIncorreto += pesquisaETrata(pLista,vTratado,ref);
		if((strcmp(vTratado,"LITERAL")==0)||(strcmp(vTratado,"CARACTERE")==0)||(strcmp(vTratado,"OK")==0)){}
		else if(strcmp(vTratado,"REAL")==0)
			seIncorreto += 1;
		else if(strcmp(vTratado,"INTEIRO")==0)
			seIncorreto += 10;
		else if((strcmp(vTratado,"LOGICO")==0)||(strcmp(vTratado,"LOG")==0))
			seIncorreto += 100;
		vTratado = strtok(NULL, " ");
	}
	return seIncorreto;
}

int comparaCaractere(struct TS *pLista, char *valor)
{
	char *vTratado = NULL;
	char *ref = (char*) malloc(sizeof(10));
	strcpy(ref,"CARACTERE");
	int seIncorreto = 0;
	vTratado = strtok(valor, " ");
	while(vTratado!=NULL)
	{
		if(naoParametrico(vTratado)==1)
			seIncorreto += pesquisaETrata(pLista,vTratado,ref);
		if((strcmp(vTratado,"CARACTERE")==0)||(strcmp(vTratado,"OK")==0)){}
		else if(strcmp(vTratado,"REAL")==0)
			seIncorreto += 1;
		else if(strcmp(vTratado,"INTEIRO")==0)
			seIncorreto += 10;
		else if((strcmp(vTratado,"LOGICO")==0)||(strcmp(vTratado,"LOG")==0))
			seIncorreto += 100;
		else if(strcmp(vTratado,"LITERAL")==0)
			seIncorreto += 1000;
		vTratado = strtok(NULL, " ");
	}
	return seIncorreto;
}

// Verifica se o Valor é coerente com o Tipo
int trataValor(struct TS *pLista, char *tipo, char *valor)
{
	int valorTratado = 0;
	if(strcmp(tipo,"REAL")==0)
		valorTratado = comparaReal(pLista, valor);
	else if(strcmp(tipo,"INTEIRO")==0)
		valorTratado = comparaInteiro(pLista, valor);
	else if(strcmp(tipo,"LOGICO")==0)
		valorTratado = comparaLogico(pLista, valor);
	else if(strcmp(tipo,"LITERAL")==0)
		valorTratado = comparaLiteral(pLista, valor);
	else if(strcmp(tipo,"CARACTERE")==0)
		valorTratado = comparaCaractere(pLista, valor);
	return valorTratado;
}

// Verifica se a lista esta vazia
int seVazia(struct TS *pLista)
{
	if(pLista==NULL)
		return 1;
	else
		return 0;
}

// Exporta os dados em Arquivos/ts.txt
void listar(struct TS *pLista)
{
    FILE *ts = fopen("Arquivos/ts.txt","w");
    fflush(ts);
	if(seVazia(pLista)==1)
	{
		fprintf(ts,"Lista Vazia!");
	}
	else
	{
		int id=1;
		struct TS *pAux;	
		pAux = pLista;
		while(pAux!=NULL)
		{
			fprintf(ts,"\n====%d====\n", id);
			fprintf(ts,"| Nome: %s\n| Tipo: %s\n| Valor: %d\n| Escopo: %d\n| Linha: %d~%d\n| Coluna: %d~%d\n",
				pAux->nome, pAux->tipo, pAux->valor, pAux->escopo, pAux->local.first_line, pAux->local.last_line, pAux->local.first_column, pAux->local.last_column);
			fprintf(ts,"\n| Registro de Erro: \n%s |\n", pAux->erro);
			id++;
			pAux = pAux->Prox;
		}
	}
    fclose(ts);
}

// Inclui com todos os Campos
struct TS *inclui(struct TS *pLista, char *n, char *t, int v, int e, struct YYLTYPE local)
{
	struct TS *pNovoNo = (struct TS*) malloc(sizeof(struct TS));
	char *nome = (char*) malloc(sizeof(n));
	strcpy(nome,n);
	char *tipo = (char*) malloc(sizeof(t));
	strcpy(tipo,t);
	pNovoNo->nome = nome;
	pNovoNo->tipo = tipo;
	pNovoNo->valor = v;
	pNovoNo->escopo = e;
	pNovoNo->local = local;
	pNovoNo->erro = NULL;
	if(seVazia(pLista)==1)
	{
		pNovoNo->Prox = pLista;
		pLista = pNovoNo;
	}
	else
	{
		struct TS *pAux;
		pNovoNo->Prox = NULL;
		pAux = pLista;
		while(pAux->Prox!=NULL)
			pAux = pAux->Prox;
		pAux->Prox = pNovoNo;
	}
	return pLista;
}

// Inclui com nome apenas
struct TS *incluiNome(struct TS *pLista, char *n, struct YYLTYPE local)
{
	struct TS *pNovoNo = (struct TS*) malloc(sizeof(struct TS));
	char *nome = (char*) malloc(sizeof(n));
	strcpy(nome,n);
	pNovoNo->nome = nome;
	pNovoNo->tipo = NULL;
	pNovoNo->valor = 0;
	pNovoNo->escopo = 0;
	pNovoNo->local = local;
	pNovoNo->erro = NULL;
	if(seVazia(pLista)==1)
	{
		pNovoNo->Prox = pLista;
		pLista = pNovoNo;
	}
	else
	{
		struct TS *pAux;
		pNovoNo->Prox = NULL;
		pAux = pLista;
		while(pAux->Prox!=NULL)
			pAux = pAux->Prox;
		pAux->Prox = pNovoNo;	
	}
	return pLista;
}

// Inclui o Valor em um no de mesmo nome
struct TS *incluiValor(struct TS *pLista, char *n, char *v, struct YYLTYPE local)
{
	struct TS *pAux;
	pAux = pLista;
	while(strcmp(pAux->nome,n)!=0)
		pAux = pAux->Prox;
	pAux->valor = trataValor(pLista,pAux->tipo,v);
	pAux->local = local;
	return pLista;
}

// Inclui tipos em um raio (min-max) de nos da Lista
struct TS *geraTipos(struct TS *pLista, const char *t, int min, int max)
{
	int i;
	char *tipo = (char*) malloc(sizeof(t));
	strcpy(tipo,t);
	struct TS *pAux;
	pAux = pLista;
	for(i=0;i<=max;i++)
	{
		if(i<min)
			pAux = pAux->Prox;
		else
		{
			pAux->tipo = tipo;
			pAux = pAux->Prox;
		}
	}

	return pLista;
}

// Exclui o primeiro no
struct TS *excluiHead(struct TS *pLista)
{
	struct TS *pAux;
	pAux = pLista;
	pLista = pAux->Prox;
	free(pAux);
	return pLista;
}

// Exclui o ultimo no
struct TS *excluiTail(struct TS *pLista)
{
	struct TS *pAux;
	pAux = pLista;
	while(pAux->Prox->Prox!=NULL)
		pAux = pAux->Prox;
	free(pAux->Prox);
	pAux->Prox = NULL;
	return pLista;
}

// Exclui um no pesquisando pelo campo nome
struct TS *excluiNome(struct TS *pLista, char *ref)
{
	struct TS *pAnt, *pPost;
	pAnt = pLista;
	while(strcmp(pAnt->Prox->nome,ref)!=0)
		pAnt = pAnt->Prox;
	pPost = pAnt->Prox->Prox;
	free(pAnt->Prox);
	pAnt->Prox=pPost;
	return pLista;
}

// Pesquisa um no e retorna 1 se existir
int existe(struct TS *pLista, char *n, char *t, int e)
{
	struct TS *pAux;
	pAux = pLista;
	while((strcmp(pAux->nome,n)!=0)||(strcmp(pAux->tipo,t)!=0)||(pAux->escopo!=e))
		pAux = pAux->Prox;
	return 1;
}

// Pesquisa um no e retorna o no
char *pesquisaNome(struct TS *pLista, char *t, int e)
{
	struct TS *pAux;
	pAux = pLista;
	while((strcmp(pAux->tipo,t)!=0)||(pAux->escopo!=e))
		pAux = pAux->Prox;
	return pAux->nome;
}

// Pesquisa um no pelo nome, valor e escopo e retorna o tipo
char *pesquisaTipo(struct TS *pLista, char *n, int e)
{
	struct TS *pAux;
	pAux = pLista;
	while((strcmp(pAux->nome,n)!=0)||(pAux->escopo!=e))
		pAux = pAux->Prox;
	return pAux->tipo;	
}

// Pesquisa um no pelo nome, tipo e escopo e retorna o valor
int pesquisaValor(struct TS *pLista, char *n, char *t, int e)
{
	struct TS *pAux;
	pAux = pLista;
	while((strcmp(pAux->nome,n)!=0)||(strcmp(pAux->tipo,t)!=0)||(pAux->escopo!=e))
		pAux = pAux->Prox;
	return pAux->valor;	
}

// Pesquisa um no pelo nome, tipo e valor e retorna o escopo
int pesquisaEscopo(struct TS *pLista, char *n, char *t)
{
	struct TS *pAux;
	pAux = pLista;
	while((strcmp(pAux->nome,n)!=0)||(strcmp(pAux->tipo,t)!=0))
		pAux = pAux->Prox;
	return pAux->escopo;	
}

// Verifica se a informação é Caractere ou Literal
char *verificaString(char *s)
{
	if(strlen(s)>3)
	{
		char *literal = (char*) malloc(sizeof(8));
		strcpy(literal,"LITERAL");
		return literal;
	}
	char *caractere = (char*) malloc(sizeof(10));
	strcpy(caractere,"CARACTERE");
	return caractere;
}

// Relatorio de Erros Semanticos em Variaveis
struct TS *geraRESporNo(struct TS *pNo)
{
	char *erro = (char*) malloc(sizeof(char));
	char *cabecalho = (char*) malloc(sizeof(150));
	struct TS *pAux = pNo;
	if(pAux->valor==0)
	{
		sprintf(cabecalho,"Variavel sem Erros Detectados.");
		strcpy(erro, cabecalho);
	}
	else
	{
		
		sprintf(cabecalho, "%d:%d: Erro: [%s]", pAux->local.first_line, pAux->local.first_column, pAux->nome);
		strcpy(erro, cabecalho);
		int contador = 0;
		int registro = pAux->valor;
		char *ocorrenciasM = (char*) malloc(sizeof(150));
		char *ocorrenciasCm = (char*) malloc(sizeof(150));
		char *ocorrenciasDm = (char*) malloc(sizeof(150));
		char *ocorrenciasm = (char*) malloc(sizeof(150));
		char *ocorrenciasC = (char*) malloc(sizeof(150));
		char *ocorrenciasD = (char*) malloc(sizeof(150));
		char *ocorrenciasU = (char*) malloc(sizeof(150));

		while(registro!=0)
		{
			if(pAux->valor>=1000000)
			{
				while(registro>=1000000)
				{
					contador++;
					registro -= 1000000;
				}
				sprintf(ocorrenciasM,"\n--> A variavel na qual esta traz referencia possui erros.\n-> Ocorrencias: %d", contador);
				strcat(erro,ocorrenciasM);
				contador = 0;
			}
			else if(pAux->valor>=100000)
			{
				while(registro>=100000)
				{
					contador++;
					registro -= 100000;
				}
				sprintf(ocorrenciasCm,"\n--> A variavel na qual esta traz referencia nao foi declarada.\n-> Ocorrencias: %d", contador);
				strcat(erro,ocorrenciasCm);
				contador = 0;
			}
			else if(pAux->valor>=10000)
			{
				while(registro>=10000)
				{
					contador++;
					registro -= 10000;
				}
				sprintf(ocorrenciasDm,"\n--> Tipo CARACTERE nao coerente com esta variavel (Do tipo: %s).\n-> Ocorrencias: %d", pAux->tipo, contador);
				strcat(erro,ocorrenciasDm);
				contador = 0;
			}
			else if(pAux->valor>=1000)
			{
				while(registro>=1000)
				{
					contador++;
					registro -= 1000;
				}
				sprintf(ocorrenciasm,"\n--> Tipo LITERAL nao coerente com esta variavel (Do tipo: %s).\n-> Ocorrencias: %d", pAux->tipo, contador);
				strcat(erro,ocorrenciasm);
				contador = 0;
			}
			else if(pAux->valor>=100)
			{
				while(registro>=100)
				{
					contador++;
					registro -= 100;
				}
				sprintf(ocorrenciasC,"\n--> Uso indevido de operadores logicos.\n-> Ocorrencias: %d", contador);
				strcat(erro,ocorrenciasC);
				contador = 0;
			}
			else if(pAux->valor>=10)
			{
				while(registro>=10)
				{
					contador++;
					registro -= 10;
				}
				sprintf(ocorrenciasD,"\n--> Tipo INTEIRO nao coerente com esta variavel (Do tipo: %s).\n-> Ocorrencias: %d", pAux->tipo, contador);
				strcat(erro,ocorrenciasD);
				contador = 0;
			}
			else if(pAux->valor>=1)
			{
				while(registro>=1)
				{
					contador++;
					registro -= 1;
				}
				sprintf(ocorrenciasU,"\n--> Tipo REAL nao coerente com esta variavel (Do tipo: %s).\n-> Ocorrencias: %d", pAux->tipo, contador);
				strcat(erro,ocorrenciasU);
				contador = 0;
			}
		}
	}
	pAux->erro = erro;
	return pAux;
}

struct TS *geraRelatorioDeErrosSemanticos(struct TS *pLista)
{
	struct TS *pAux = pLista;
	while(pAux!=NULL)
	{
		pAux = geraRESporNo(pAux);
		pAux = pAux->Prox;
	}
	return pLista;
}