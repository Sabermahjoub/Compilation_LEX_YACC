%{
#include<stdio.h>
#include <string.h>
%}

%%
[0-9]+ {printf("[%s] : un nombre \n",yytext);}
(aa|bb)*((ab|ba)(aa|bb)*(ab|ba)(aa|bb)*)* {printf("[%s] : nombre pair de a et de b \n",yytext);}
(a*b*) {printf("[%s] : les a precedent les b \n",yytext);}
[a-zA-Z][a-zA-Z0-9_]* {printf("[%s] : un identificateur \n",yytext);}
.* {printf("autre \n");}
%%
int yywrap() {return 1;}

int main()//int argc, char *argv[])
{

// freopen("resultat.txt", "w", stdout);
// ++argv, --argc;
// if ( argc > 0 )
// yyin = fopen( argv[0], "r" );
// else
// yyin = stdin;
yylex() ;
}