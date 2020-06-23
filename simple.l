%{
	#include <string.h>
	#include "util.h"
	#include "y.tab.h"
	#include "errormsg.h"

	int charPos=1;

	extern YYSTYPE yylval;

	int yywrap(void){
 		charPos=1;
 		return 1;
	}

	void adjust(void){
 		EM_tokPos=charPos;
 		charPos+=yyleng;
	}

	#define MAX_STR_CONST   256
	char string_buf[MAX_STR_CONST];
	char *string_buf_ptr;

%}

%%

"def" 	      				{adjust(); return DEF;}
"si"		 	  			{adjust(); return SI;}
"otro"	 	  				{adjust(); return OTRO;}
"mientras" 	  				{adjust(); return MIENTRAS;}
"despliega" 	  			{adjust(); return DESPLIEGA;}
"regresa"					{adjust(); return REGRESA;}

"=="		 	  			{adjust();  return IGUAL;}
"<>"			  			{adjust();  return DIFER;}
"<="			  			{adjust();  return LESSOREQ;}
">="			  			{adjust();  return MOREOREQ;}

"{"           				{adjust(); return '{';}
"}"           				{adjust(); return '}';}
"("           				{adjust(); return '(';}
")"           				{adjust(); return ')';}
"="           				{adjust(); return '=';}
"+"           				{adjust(); return '+';}
"-"           				{adjust(); return '-';}
"*"           				{adjust(); return '*';}
"/"           				{adjust(); return '/';}
"&"           				{adjust(); return '&';}
"|"           				{adjust(); return '|';}
":"           				{adjust(); return ':';}
";"           				{adjust(); return ';';}
","		      				{adjust(); return ',';}

^(?:[\t ]*(?:\r?\n|\r))+	{adjust(); continue;}
[ \t]      	  				{adjust(); continue;}
[\n]       	  				{adjust(); EM_newline(); continue;}
[0-9]+		  				{adjust(); yylval.ival=atoi(yytext); return ENTERO;}
---(.|\n)*--- 				{adjust(); return COMENTARIO;}
[_a-zA-Z][_a-zA-Z0-9]*		{adjust(); yylval.sval=yytext; return ID;}
\'.*\'						{adjust(); yylval.sval=yytext; return CADENA;}

<<EOF>>       				{printf("\n Fin de Archivo encontrado"); exit(0); }

.             				{adjust(); EM_error(EM_tokPos, yytext);}
