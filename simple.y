%{

#include <stdio.h>
#include "util.h"
#include "errormsg.h"
#include "tokens.h"

// Prototipo de la funcion de analisis lexico
int yylex(void);

void yyerror(char *s) {
	EM_error(EM_tokPos, "%s", s);
}

%}

%token  ID
%token  COMENTARIO
%token	ENTERO
%token	CADENA

%token	REGRESA
%token  DEF
%token	SI
%token	OTRO
%token	MIENTRAS
%token	DESPLIEGA

%token	IGUAL
%token	DIFER
%token	LESSOREQ
%token	MOREOREQ

%left '+' '-'
%left '*' '/'
%left '='
%left '&' '|'

%union {
  int ival;
  char *sval;
};    
%start program

// Gramatica del lenguaje                             
%%
program: sentList instBlock
	| instBlock

sent: assignation ';'
	| callFunction ';'
	| REGRESA '(' ID ')' ';'
	| DESPLIEGA '(' CADENA ')' ';'
	| defFunction
	| controlSentence

assignation: ID
	| ID '=' arithExpression

callFunction: ID '=' paramList '(' ')'

defFunction: DEF ID '(' paramList ')' instBlock

controlSentence: whileSentence
	| ifSentence

ifSentence: SI '(' logicSentence ')' '{' sentList '}' %prec SI
    | SI '(' logicSentence ')' '{' sentList '}' OTRO '{' sentList '}'

whileSentence: MIENTRAS '(' logicSentence ')' '{' sentList '}'

sentList: sent ';'
	| sent ';' sentList

instBlock: '{' sentList '}'
	| '{' '}'

param:	arithExpression
	| arithExpression ',' param

paramList: '(' param ')'
	| '(' ')'

arithExpression: ENTERO
	| ID
	| ENTERO '+' arithExpression
	| ENTERO '-' arithExpression
	| ENTERO '*' arithExpression
	| ENTERO '/' arithExpression
	| ID '+' arithExpression
	| ID '-' arithExpression
	| ID '*' arithExpression
	| ID '/' arithExpression

logicExpression: arithExpression LESSOREQ arithExpression
	| arithExpression MOREOREQ arithExpression
	| arithExpression DIFER arithExpression
	| arithExpression IGUAL arithExpression
	| arithExpression '>' arithExpression
	| arithExpression '<' arithExpression
	| ID
	| ENTERO

logicSentence: logicExpression '&' logicExpression
	| logicExpression '|' logicExpression
	| '(' logicSentence ')'