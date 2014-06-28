portugolrb: lexts.l parts.y
	bison -d parts.y
	mv parts.tab.h parts.h
	mv parts.tab.c parts.c
	flex lexts.l
	mv lex.yy.c lexts.c
	g++ parts.c lexts.c -Wall -o portugolrb -lfl -lm

create: portugolrb
	./portugolrb entrada.gpt >> saida.rb

recreate: portugolrb
	rm saida.rb
	./portugolrb entrada.gpt >> saida.rb
clean:
	rm -f lexts.c parts.c parts.h portugolrb saida.rb
