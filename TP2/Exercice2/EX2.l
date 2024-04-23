%option noyywrap nodefault yylineno case-insensitive
%{
#include<stdio.h>
#include "EX2.tab.h"

%}
id [a-zA-Z][a-zA-Z0-9_]*
%%
CREATE {return command;}
TABLE {return table;}
int|integer {return INT;}
PRIMARY[[:space:]]KEY {return PK;}
varchar[(][0-9]+[)] {return varchar;}
DATE {return date;}
[,] {return virg;}
[;] {return fin;}
[(] {return parOuv;}
[)] {return parFerm;}
[0-9]+ {yylval=atoi(yytext) ; return number;}
{id} {return identifier;}
[ \t\n]* ;
.  {printf("%s : unrecognized characters ",yytext);};

%%