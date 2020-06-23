#ifndef Y_TAB_H
#define Y_TAB_H
typedef union {
   int pos;
   int ival;
   string sval;
} YYSTYPE;

// Tokens multilexema
#define ID	         258
#define COMENTARIO   259
#define ENTERO	      260
#define CADENA	      261 // 

// Palabras reservadas
#define REGRESA      262 // regresa
#define DEF          263 // def
#define SI           264 // si
#define OTRO         265 // otro
#define MIENTRAS     266 // mientras
#define DESPLIEGA    267 // despliega

// Operadores y signos de puntacion
#define IGUAL        268 // ==
#define DIFER        269 // <>
#define LESSOREQ     270 // <=
#define MOREOREQ     271 // >=

extern YYSTYPE yylval;
#endif
