#include <stdio.h>
#include <stdlib.h>
#include "util.h"
#include "errormsg.h"
#include "y.tab.h"

YYSTYPE yylval;

int yylex(void); /* prototipo de la función de análisis léxico generada por flex */

string tokname(int tok);
/*char *tokname(inmt*/

string toknames[] = {"ID", "COMENTARIO", "ENTERO","CADENA",

                     "REGRESA","DEF","SI","OTRO","MIENTRAS",
                     "DESPLIEGA",
                     
                     "IGUAL", "DIFER", "LESSOREQ", "MOREOREQ"};


string tokname(int tok) {
	return tok<258 || tok>271 ? "TOKEN NO VALIDO" : toknames[tok-258];
}

int main(int argc, char **argv) {
	string fname; int tok;
	if (argc!=2) {fprintf(stderr,"Uso: driver archivo.simple\n"); exit(1);}
	fname=argv[1];
	EM_reset(fname);
	for(;;) {
		tok=yylex();
		if (tok==0) break;
		else if(tok<=255) printf("S: %c\t",tok);
		else {
       		switch(tok) {
         		case ID: case CADENA: 
				 	printf("%s: %s\t", tokname(tok), yylval.sval);
           			break;
         		case COMENTARIO:
           			printf("%s", tokname(tok));
					break;
         		case ENTERO:
           			printf("%s: %d\t", tokname(tok), yylval.ival);
           			break;
         		case IGUAL: case DIFER: case LESSOREQ: case MOREOREQ:
          			printf("C: %s\t", tokname(tok));
          			break;
         		case REGRESA: case DEF: case SI: case OTRO: case MIENTRAS: case DESPLIEGA:
           			printf("%s\t", tokname(tok));
           			break;
         		default:
           			printf("%s: %s\t", tokname(tok), yylval.sval);
       		}
		}
 	}
 	return 0;
}
