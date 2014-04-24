// Biblioteca para Tratamento da Lista da Tabela de Símbolos

struct TS
{
	char *nome;
	char *tipo;
	char *valor;
	bool escopo;
	struct TS *Prox;
	TS(){nome=NULL;tipo=NULL;valor=NULL;escopo=false;Prox=NULL}
};

bool Vazia(TS *pLista)
{
	if(pLista==NULL)
		return true;
	else
		return false;
}

TS *IHead(TS *pLista, char *n, char *t, char *v, bool e)
{
	TS *pNovoNo;
	pNovoNo = (TS*) malloc(sizeof(TS));
	pNovoNo->nome = n;
	pNovoNo->tipo = t;
	pNovoNo->valor = v;
	pNovoNo->escopo = e;
	pNovoNo->Prox = pLista;
	pLista = pNovoNo;
	return pLista;
}

TS *IHeadNome(TS *pLista, char *n)
{
	TS *pNovoNo;
	pNovoNo = (TS*) malloc(sizeof(TS));
	pNovoNo->nome = n;
	pNovoNo->tipo = NULL;
	pNovoNo->valor = NULL;
	pNovoNo->escopo = false;
	pNovoNo->Prox = pLista;
	pLista = pNovoNo;
	return pLista;
}

TS *EHead(TS *pLista)
{
	TS *pAux;
	pAux = pLista;
	pLista = pAux->Prox;
	free(pAux);
	return pLista;
}

TS *ITail(TS *pLista, char *n, char *t, char *v, bool e)
{
	TS *pNovoNo, *pAux;
	pNovoNo = (TS*) malloc(sizeof(TS));
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

TS *ITailNome(TS *pLista, char *n, bool e)
{
	TS *pNovoNo, *pAux;
	pNovoNo = (TS*) malloc(sizeof(TS));
	pNovoNo->nome = n;
	pNovoNo->tipo = NULL;
	pNovoNo->valor = NULL;
	pNovoNo->escopo = false;
	pNovoNo->Prox = NULL;
	pAux = pLista;
	while(pAux->Prox!=NULL)
		pAux = pAux->Prox;
	pAux->Prox = pNovoNo;
	return pLista;
}

TS *ETail(TS *pLista)
{
	TS *pAux;
	pAux = pLista;
	while(pAux->Prox->Prox!=NULL)
		pAux = pAux->Prox;
	free(pAux->Prox);
	pAux->Prox = NULL;
	return pLista;
}

TS *IBefNome(TS *pLista, char *ref, char *n, char *t, char *v, bool e)
{
	TS *pNovoNo, *pAux;
	pNovoNo = (TS*) malloc(sizeof(TS));
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

TS *IBefNomeNome(TS *pLista, char *ref, char *n)
{
	TS *pNovoNo, *pAux;
	pNovoNo = (TS*) malloc(sizeof(TS));
	pNovoNo->nome = n;
	pNovoNo->tipo = NULL;
	pNovoNo->valor = NULL;
	pNovoNo->escopo = false;
	pAux = pLista;
	while(pAux->Prox->nome!= ref)
		pAux = pAux->Prox;
	pNovoNo->Prox = pAux->Prox;
	pAux->Prox = pNovoNo;
	return pLista;
}

TS *ENoNome(TS *pLista, char *ref)
{
	TS *pAnt, *pPost;
	pAnt = pLista;
	while(pAnt->Prox->nome!=ref)
		pAnt = pAnt->Prox;
	pPost = pAnt->Prox->Prox;
	free(pAnt->Prox);
	pAnt->Prox=pPost;
	return pLista;
}

TS *MNomeNome (TS *pLista, char *ref, char *n)
{
	TS *pAux;
	pAux = pLista;
	while(pAux->nome!=ref)
		pAux = pAux->Prox;
	pAux->nome = n;
	return pLista;
}

TS *MNomeTipo (TS *pLista, char *ref, char *t)
{
	TS *pAux;
	pAux = pLista;
	while(pAux->nome!=ref)
		pAux = pAux->Prox;
	pAux->tipo = t;
	return pLista;
}

TS *MNomeValor (TS *pLista, char *ref, char *v)
{
	TS *pAux;
	pAux = pLista;
	while(pAux->nome!=ref)
		pAux = pAux->Prox;
	pAux->valor = v;
	return pLista;
}

TS *MNomeEscopo (TS *pLista, char *ref, bool e)
{
	TS *pAux;
	pAux = pLista;
	while(pAux->nome!=ref)
		pAux = pAux->Prox;
	pAux->escopo = e;
	return pLista;
}
