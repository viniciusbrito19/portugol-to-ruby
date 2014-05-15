// Biblioteca para Tratamento da Lista da Tabela de Símbolos
#include<stdio.h>
#include<string.h>

struct TS
{
	char *nome;
	char *tipo;
	char *valor;
	int escopo;
	struct TS *Prox;
};

int seVazia(struct TS *pLista)
{
	if(pLista==NULL)
		return 1;
	else
		return 0;
}

struct TS *inclui(struct TS *pLista, char *n, char *t, char *v, int e)
{
	char *nome = (char*) malloc(sizeof(n));
	strcpy(nome,n);
	struct TS *pNovoNo;
	pNovoNo = (struct TS*) malloc(sizeof(struct TS));
	pNovoNo->nome = nome;
	pNovoNo->tipo = t;
	pNovoNo->valor = v;
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
	struct TS *pNovoNo;
	pNovoNo = (struct TS*) malloc(sizeof(struct TS));
	pNovoNo->nome = n;
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

struct TS *EHead(struct TS *pLista)
{
	struct TS *pAux;
	pAux = pLista;
	pLista = pAux->Prox;
	free(pAux);
	return pLista;
}

struct TS *ITail(struct TS *pLista, char *n, char *t, char *v, int e)
{
	struct TS *pNovoNo, *pAux;
	pNovoNo = (struct TS*) malloc(sizeof(struct TS));
	pNovoNo->nome = n;
	pNovoNo->tipo = t;
	pNovoNo->valor = v;
	pNovoNo->escopo = e;
	pNovoNo->Prox = NULL;
	pAux = pLista;
	while(pAux->Prox!=NULL)
		pAux = pAux->Prox;
	pAux->Prox = pNovoNo;
	return pLista;
}

struct TS *ITailNome(struct TS *pLista, char *n, int e)
{
	struct TS *pNovoNo, *pAux;
	pNovoNo = (struct TS*) malloc(sizeof(struct TS));
	pNovoNo->nome = n;
	pNovoNo->tipo = NULL;
	pNovoNo->valor = NULL;
	pNovoNo->escopo = 0;
	pNovoNo->Prox = NULL;
	pAux = pLista;
	while(pAux->Prox!=NULL)
		pAux = pAux->Prox;
	pAux->Prox = pNovoNo;
	return pLista;
}

struct TS *ETail(struct TS *pLista)
{
	struct TS *pAux;
	pAux = pLista;
	while(pAux->Prox->Prox!=NULL)
		pAux = pAux->Prox;
	free(pAux->Prox);
	pAux->Prox = NULL;
	return pLista;
}

struct TS *IBefNome(struct TS *pLista, char *ref, char *n, char *t, char *v, int e)
{
	struct TS *pNovoNo, *pAux;
	pNovoNo = (struct TS*) malloc(sizeof(struct TS));
	pNovoNo->nome = n;
	pNovoNo->tipo = t;
	pNovoNo->valor = v;
	pNovoNo->escopo = e;
	pAux = pLista;
	while(pAux->Prox->nome!= ref)
		pAux = pAux->Prox;
	pNovoNo->Prox = pAux->Prox;
	pAux->Prox = pNovoNo;
	return pLista;
}

struct TS *IBefNomeNome(struct TS *pLista, char *ref, char *n)
{
	struct TS *pNovoNo, *pAux;
	pNovoNo = (struct TS*) malloc(sizeof(struct TS));
	pNovoNo->nome = n;
	pNovoNo->tipo = NULL;
	pNovoNo->valor = NULL;
	pNovoNo->escopo = 0;
	pAux = pLista;
	while(pAux->Prox->nome!= ref)
		pAux = pAux->Prox;
	pNovoNo->Prox = pAux->Prox;
	pAux->Prox = pNovoNo;
	return pLista;
}

struct TS *ENoNome(struct TS *pLista, char *ref)
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

struct TS *MNomeNome (struct TS *pLista, char *ref, char *n)
{
	struct TS *pAux;
	pAux = pLista;
	while(pAux->nome!=ref)
		pAux = pAux->Prox;
	pAux->nome = n;
	return pLista;
}

struct TS *MNomeTipo (struct TS *pLista, char *ref, char *t)
{
	struct TS *pAux;
	pAux = pLista;
	while(pAux->nome!=ref)
		pAux = pAux->Prox;
	pAux->tipo = t;
	return pLista;
}

struct TS *MNomeValor (struct TS *pLista, char *ref, char *v)
{
	struct TS *pAux;
	pAux = pLista;
	while(pAux->nome!=ref)
		pAux = pAux->Prox;
	pAux->valor = v;
	return pLista;
}

struct TS *MNomeEscopo (struct TS *pLista, char *ref, int e)
{
	struct TS *pAux;
	pAux = pLista;
	while(pAux->nome!=ref)
		pAux = pAux->Prox;
	pAux->escopo = e;
	return pLista;
}

struct TS* *modificaTipo (struct TS *pLista, char *ref, int min, int max)
{
	int i;
	struct TS *pAux;
	pAux = pLista;
	for(i=0;i<=max;i++)
	{
		if(i<min)
			pAux = pAux->Prox;
		else
		{
			pAux->tipo = ref;
			pAux = pAux->Prox;
		}
	}
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
	
	do
	{
		printf("\n%d %s \t %s \t %s \t %d\n", id, pAux->nome, pAux->tipo, pAux->valor, pAux->escopo);
		id++;
		pAux = pAux->Prox;
	}while(pAux->Prox!=NULL);
	}
}
