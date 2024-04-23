%{
#include <stdio.h>
#include<math.h>
#include "EX1.tab.h"
%}

%%
[0-9]+ {yylval=atoi(yytext); return NB;}
produit {return PROD;}
somme {return SOM;}
sous {return SOUS;}
div {return DIV;}
[,|.] {return yytext[0];}
[$] {return FIN;}
[ \t\n] {}
. {printf("Erreur");}

%%
int yywrap() {return 1;}