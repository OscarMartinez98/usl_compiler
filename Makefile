parsetst: parsetst.o y.tab.o lex.yy.o errormsg.o util.o
	gcc -g -o parsetst parsetst.o y.tab.o lex.yy.o errormsg.o util.o

lextest: driver.o lex.yy.o errormsg.o util.o
	gcc -g -o lextest driver.o lex.yy.o errormsg.o util.o

parsetst.o: parsetst.c tokens.h errormsg.h util.h
	gcc -g -c parsetst.c

driver.o: driver.c y.tab.h errormsg.h util.h
	gcc -g -c driver.c

lex.yy.o: lex.yy.c y.tab.h errormsg.h util.h
	gcc -g -c lex.yy.c

lex.yy.c: simple.l y.tab.h simple.y
	flex simple.l

errormsg.o: errormsg.c errormsg.h util.h
	gcc -g -c errormsg.c

y.tab.o: y.tab.c errormsg.h util.h
	gcc -g -c y.tab.c

y.tab.c: simple.y
	bison -dvy simple.y

util.o: util.c util.h
	gcc -g -c util.c

clean:
	@echo "Cleaning up..."
	rm -f a.out lextest *.o lex.yy.c

realclean: 
	rm -f a.out parsetst lextest *.o lex.yy.c y.tab.c y.tab.h\
	y.output y.vcg *~