%option noyywrap nodefault yylineno case-insensitive
%{
#include<stdio.h>
#include "EX2.tab.h"
%}
id [a-zA-Z][a-zA-Z0-9_]*
%%
(c|C)(R|r)(E|e)(A|a)(T|t)(E|e) {return command;}
(T|t)(A|a)(B|b)(L|l)(E|e) {return table;}
int|integer {return INT;}
PRIMARY[[:space:]]KEY {return PK;}
varchar[(][0-9]+[)] {printf("var");return varchar;}
DATE {return date;}
[,] {return virg;}
[;] {return fin;}
[(] {return parOuv;}
[)] {return parFerm;}
[0-9]+ {yylval=atoi(yytext) ; return number;}
{id} {printf("id");return identifier;}
[ \n\t] ;
.* {printf("%s :Unrecognized characters ! ",yytext);}

%%