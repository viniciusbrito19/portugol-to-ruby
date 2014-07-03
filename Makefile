all: ptrc

ptrcheck: scanner.l parser_logger.y
	bison -d parser_logger.y
	mv parser_logger.tab.h parser_logger.h
	mv parser_logger.tab.c parser_logger.c
	flex scanner.l
	mv lex.yy.c scanner.c
	g++ parser_logger.c scanner.c -Wall -o filechecker -lfl -lm

ptrmake: scanner.l parser_main.y
	bison -d parser_main.y
	mv parser_main.tab.c parser_main.c
	flex scanner.l
	mv lex.yy.c scanner.c
	g++ parser_main.c scanner.c -Wall -o ptrc -lfl -lm

ptrc: clean ptrcheck ptrmake
	./filechecker entrada.gpt
	./ptrc entrada.gpt >> saida.rb

clean:
	rm -f scanner.c parser_logger.c parser_logger.h parser_main.h parser_main.c saida.rb filechecker ptrc