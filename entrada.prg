ALGORITMO Fatorial; 
VARIAVEIS 
res,fat,x:INTEIRO; 
FIM-VARIAVEIS 
INICIO
	imprima("Digite um número:");
	fat:=leia();
	res := 1;
	para x de fat ate 1 passo -1 faca
		res := res*x;
	fim-para	
	imprima("Resultado é:",res);
FIM
