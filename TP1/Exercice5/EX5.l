%{
#include <stdio.h>
#include <string.h>
#include "EX5.h"
%}
entier -?[0-9]+
reel -?[0-9]*(.[0-9]+)?(e|E)?[0-9]+
ident [a-zA-Z][a-zA-Z0-9_#]*
oparth [+]|[-]|[*]|[/]
oprel <|>|<>|<=|>=|==|!=
motcle if|else|while
sp [[:space:]]
chaine \"[^\"\n]*\"
commentaire #^#.*#?

%%
{motcle} {printf("motcle");return motcle;}
{chaine} {printf("chaine");return chaine;}
{oparth} {printf("oparth");return oparth;}
{oprel} {printf("oprel");return oprel;}
{ident} {printf("ident");return ident;}
{entier} {printf("entier");return entier;}
{reel} {printf("reel");return reel;}
{commentaire} {printf("commentaire");return commentaire;}
[ \t\n] ;
.* {printf("%s caractere pas reconnu ",yytext); return SyntaxError }
%%
int yywrap(void) {return 1;}

// int main()
// {
// yylex() ;
// return 0;
// }