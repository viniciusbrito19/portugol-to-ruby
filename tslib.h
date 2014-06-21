// Biblioteca para Tratamento da Lista da Tabela de Simbolos
#include<stdio.h>
#include<string.h>

// Struct
struct TS
{
	char *nome;
	char *tipo;
	char *valor;
	int escopo;
	struct TS *Prox;
};

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
			fprintf(ts,"| Nome: %s\n| Tipo: %s\n| Valor: %s\n| Escopo: %d\n",
				pAux->nome, pAux->tipo, pAux->valor, pAux->escopo);
			id++;
			pAux = pAux->Prox;
		}
	}
    fclose(ts);
}

// Inclui com todos os Campos
struct TS *inclui(struct TS *pLista, char *n, char *t, char *v, int e)
{
	struct TS *pNovoNo = (struct TS*) malloc(sizeof(struct TS));
	char *nome = (char*) malloc(sizeof(n));
	strcpy(nome,n);
	char *tipo = (char*) malloc(sizeof(t));
	strcpy(tipo,t);
	char *valor = (char*) malloc(sizeof(v));
	strcpy(valor,v);
	pNovoNo->nome = nome;
	pNovoNo->tipo = tipo;
	pNovoNo->valor = valor;
	pNovoNo->escopo = e;
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
struct TS *incluiNome(struct TS *pLista, char *n)
{
	struct TS *pNovoNo = (struct TS*) malloc(sizeof(struct TS));
	char *nome = (char*) malloc(sizeof(n));
	strcpy(nome,n);
	pNovoNo->nome = nome;
	pNovoNo->tipo = NULL;
	pNovoNo->valor = NULL;
	pNovoNo->escopo = 0;	
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
struct TS *incluiValor(struct TS *pLista, char *n, char *v)
{
	struct TS *pAux;
	char *valor = (char*) malloc(sizeof(v));
	strcpy(valor,v);
	pAux = pLista;
	while(strcmp(pAux->nome,n)!=0)
		pAux = pAux->Prox;
	pAux->valor = valor;
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
int existe(struct TS *pLista, char *n, char *t, char *v, int e)
{
	struct TS *pAux;
	pAux = pLista;
	while((strcmp(pAux->nome,n)!=0)||(strcmp(pAux->tipo,t)!=0)||(strcmp(pAux->valor,v)!=0)||(pAux->escopo!=e))
		pAux = pAux->Prox;
	return 1;
}

// Retorna o primeiro no econtrado com o mesmo nome
struct TS *pesquisa(struct TS *pLista, char *n)
{
	struct TS *pAux;
	pAux = pLista;
	while(strcmp(pAux->nome,n)!=0)
		pAux = pAux->Prox;
	return pAux;
}

// Pesquisa um no e retorna o no
char *pesquisaNome(struct TS *pLista, char *t, char *v, int e)
{
	struct TS *pAux;
	pAux = pLista;
	while((strcmp(pAux->tipo,t)!=0)||(strcmp(pAux->valor,v)!=0)||(pAux->escopo!=e))
		pAux = pAux->Prox;
	return pAux->nome;
}

// Pesquisa um no pelo nome, valor e escopo e retorna o tipo
char *pesquisaTipo(struct TS *pLista, char *n, char *v, int e)
{
	struct TS *pAux;
	pAux = pLista;
	while((strcmp(pAux->nome,n)!=0)||(strcmp(pAux->valor,v)!=0)||(pAux->escopo!=e))
		pAux = pAux->Prox;
	return pAux->tipo;	
}

// Pesquisa um no pelo nome, tipo e escopo e retorna o valor
char *pesquisaValor(struct TS *pLista, char *n, char *t, int e)
{
	struct TS *pAux;
	pAux = pLista;
	while((strcmp(pAux->nome,n)!=0)||(strcmp(pAux->tipo,t)!=0)||(pAux->escopo!=e))
		pAux = pAux->Prox;
	return pAux->valor;	
}

// Pesquisa um no pelo nome, tipo e valor e retorna o escopo
int pesquisaEscopo(struct TS *pLista, char *n, char *t, char *v)
{
	struct TS *pAux;
	pAux = pLista;
	while((strcmp(pAux->nome,n)!=0)||(strcmp(pAux->tipo,t)!=0)||(strcmp(pAux->valor,v)!=0))
		pAux = pAux->Prox;
	return pAux->escopo;	
}