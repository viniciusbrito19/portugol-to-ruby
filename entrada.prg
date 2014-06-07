ALGORITMO Fatorial; 
VARIAVEIS 
res,fat,x:INTEIRO; 
FIM-VARIAVEIS 
INICIO
<<<<<<< HEAD
	a:=leia();
	
	imprima("Texto",x);

	imprima(x,"Texto");
	
	imprima(x,"Texto",y);

	imprima("Texto",x,"Texto2");

	imprima(x,"Texto",y,"Texto2");
 
=======
	imprima("Digite um número:");
	fat:=leia();
	res := 1;
	para x de fat ate 1 passo -1 faca
		res := res*x;
	fim-para	
	imprima("Resultado é:",res);
>>>>>>> c7f601cf294e50aa90d1509f32b31056e65975ea
FIM
