portugolrb: scanner.l parser.y
	bison -d parser.y
	mv parser.tab.h parser.h
	mv parser.tab.c parser.c
	flex scanner.l
	mv lex.yy.c scanner.c
	g++ parser.c scanner.c -Wall -o portugolrb -lfl -lm

create: portugolrb
	./portugolrb entrada.gpt >> saida.rb

recreate: portugolrb
	rm saida.rb
	./portugolrb entrada.gpt >> saida.rb
clean:
	rm -f scanner.c parser.c parser.h portugolrb saida.rb
