/*
 * File: lex.c
 * use "gcc lex.yy.c errormsg.c util.c -o a.out -ll" to build
 */


%{
#include <string.h>
#include "include/util.h"
#include "include/tokens.h"
#include "include/errormsg.h"
union {int ival; string sval; double fval;} yylval;
int charPos = 1;
#define ADJ (EM_tokPos=charPos, charPos+=yyleng)
%}
identifiers [a-zA-Z][a-zA-Z0-9_]*
digits [0-9]+
whitespace [ \t]

%x COMMENT
%%

<INITIAL>{whitespace}				     			 {ADJ; continue;}
<INITIAL>{identifiers}                               {ADJ; yylval.sval = String(yytext); printf("ID\n"); return ID;}
<INITIAL>{digits}                                    {ADJ; yylval.ival = atoi(yytext); printf("INT\n"); return INT;}
<INITIAL>({digits}"."[0-9]*)|([0-9]*"."{digits})     {ADJ; yylval.fval = atof(yytext); printf("REAL\n"); return REAL;}
<INITIAL>("--"[a-z]*"\n")|(" "|"\n"|"\t")+           {ADJ;}

<INITIAL>","					     {ADJ; printf("COMMA\n"); return COMMA;}
<INITIAL>":"					     {ADJ; printf("COLON\n"); return COLON;}
<INITIAL>";"					     {ADJ; printf("SEMICOLON\n"); return SEMICOLON;}
<INITIAL>"("					     {ADJ; printf("LPAREN\n"); return LPAREN;}
<INITIAL>")"					     {ADJ; printf("RPAREN\n"); return RPAREN;}
<INITIAL>"["					     {ADJ; printf("LBRACK\n"); return LBRACK;}
<INITIAL>"]"					     {ADJ; printf("RBRACK\n"); return RBRACK;}
<INITIAL>"{"					     {ADJ; printf("LBRACE\n"); return LBRACE;}
<INITIAL>"}"					     {ADJ; printf("RBRACE\n"); return RBRACE;}
<INITIAL>"."					     {ADJ; printf("DOT\n"); return DOT;}
<INITIAL>"+"					     {ADJ; printf("PLUS\n"); return PLUS;}
<INITIAL>"-"					     {ADJ; printf("MINUS\n"); return MINUS;}
<INITIAL>"*"					     {ADJ; printf("TIMES\n"); return TIMES;}
<INITIAL>"/"					     {ADJ; printf("DIVIDE\n"); return DIVIDE;}
<INITIAL>"="					     {ADJ; printf("EQ\n"); return EQ;}
<INITIAL>"<>"					     {ADJ; printf("NEQ\n"); return NEQ;}
<INITIAL>"<"					     {ADJ; printf("LT\n"); return LT;}
<INITIAL>"<="					     {ADJ; printf("LE\n"); return LE;}
<INITIAL>">"					     {ADJ; printf("GR\n"); return GT;}
<INITIAL>">="					     {ADJ; printf("GE\n"); return GE;}
<INITIAL>"&"					     {ADJ; printf("AND\n"); return AND;}
<INITIAL>"|"					     {ADJ; printf("OR\n"); return OR;}
<INITIAL>":="					     {ADJ; printf("ASSIGN\n"); return ASSIGN;}

<INITIAL>"while"					 {ADJ; printf("WHILE\n"); return WHILE;}
<INITIAL>"for"						 {ADJ; printf("FOR\n"); return FOR;}
<INITIAL>"to"						 {ADJ; printf("TO\n"); return TO;}
<INITIAL>"break"					 {ADJ; printf("BREAK\n"); return BREAK;}
<INITIAL>"let"						 {ADJ; printf("LET\n"); return LET;}
<INITIAL>"in"						 {ADJ; printf("IN\n"); return IN;}
<INITIAL>"end"						 {ADJ; printf("END\n"); return END;}
<INITIAL>"function"		 			 {ADJ; printf("FUNCTION\n"); return FUNCTION;}
<INITIAL>"var"			 			 {ADJ; printf("VAR\n"); return VAR;}
<INITIAL>"type"						 {ADJ; printf("TYPE\n"); return TYPE;}
<INITIAL>"array"					 {ADJ; printf("ARRAY\n"); return ARRAY;}
<INITIAL>"if"						 {ADJ; printf("IF\n"); return IF;}
<INITIAL>"then"						 {ADJ; printf("THEN\n"); return THEN;}
<INITIAL>"else"						 {ADJ; printf("ELSE\n"); return ELSE;}
<INITIAL>"do"						 {ADJ; printf("DO\n"); return DO;}
<INITIAL>"of"						 {ADJ; printf("OF\n"); return OF;}
<INITIAL>"nil"						 {ADJ; printf("NIL\n"); return NIL;}

<COMMENT>[0-9][a-zA-Z0-9]*			     {ADJ; EM_error(EM_tokPos, "id cannot start with a number");}
<COMMENT>.                                           {ADJ; EM_error(EM_tokPos, "illegal character");}
