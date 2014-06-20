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

// Relacionamentos com a Lista
int seVazia(struct TS *pLista)
{
	if(pLista==NULL)
		return 1;
	else
		return 0;
}

void listar(struct TS *pLista)
{
	if(seVazia(pLista)==1)
	{
		printf("Lista Vazia!");
	}
	else
	{
		int id=1;
		struct TS *pAux;	
		pAux = pLista;
    	FILE *ts = fopen("Arquivos/ts.txt","w");
    	fflush(ts);
		while(pAux!=NULL)
		{
			fprintf(ts,"\n====%d====\n", id);
			fprintf(ts,"| Nome: %s\n| Tipo: %s\n| Valor: %s\n| Escopo: %d\n",
				pAux->nome, pAux->tipo, pAux->valor, pAux->escopo);
			id++;
			pAux = pAux->Prox;
		}
    	fclose(ts);		
	}
}

// Inclusoes
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

struct TS *geraTipos (struct TS *pLista, char *t, int min, int max)
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

// Exclusoes
struct TS *excluiHead(struct TS *pLista)
{
	struct TS *pAux;
	pAux = pLista;
	pLista = pAux->Prox;
	free(pAux);
	return pLista;
}

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

struct TS *excluiNome(struct TS *pLista, char *ref)
{
	struct TS *pAnt, *pPost;
	pAnt = pLista;
	while(pAnt->Prox->nome!=ref)
		pAnt = pAnt->Prox;
	pPost = pAnt->Prox->Prox;
	free(pAnt->Prox);
	pAnt->Prox=pPost;
	return pLista;
}
