CFLAGS=-g
BISON=bison
FLEX=flex
 
parser: parser.o scanner.o
	$(CC) -o parser scanner.o parser.o
 
parser.c: parser.y
	$(BISON) -d -oparser.c parser.y
 
scanner.c: scanner.l
	$(FLEX) -oscanner.c scanner.l
 
clean:
	rm -f scanner.c scanner.o parser.c parser.o parser.h parser
