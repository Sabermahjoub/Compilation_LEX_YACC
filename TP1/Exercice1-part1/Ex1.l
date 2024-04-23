%{
#include<stdio.h>
#include <string.h>
%}

%%
(0|1)+ {printf("[%s] : un nombre binaire  \n",yytext);}
.* {printf("[%s] : N'est pas un nombre binaire \n",yytext);}
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


// 


