/*
 * File: lex.c
 */


%{
#include <string.h>
#include "include/util.h"
#include "include/tokens.h"
#include "include/errormsg.h"
int charPos = 1;
#define ADJ (EM_tokPos=charPos, charPos+=yyleng)
%}
digits [0-9]+
%%
if                                          {ADJ; return IF;}
[a-z][a-z0-9]*                              {ADJ; yylval.sval = String(yytext); return ID;}
{digits}                                    {ADJ; yylval.ival = atoi(yytext); return INT;}
({digits}"."[0-9]*)|([0-9]*"."{digits})     {ADJ; yylval.fval = atof(yytext); return REAL;}
("--"[a-z]*"\n")|(" "|"\n"|"\t")+           {ADJ;}
.                                           {ADJ; EM_error(EM_tokPos, "illegal character");}
