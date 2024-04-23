%{
#include <stdio.h>
#include <string.h>
#include "EX5.h"
%}
entier -?[0-9]+
reel {entier}.{entier}
exposant -?[0-9]*\.[0-9]+(e)?([0-9]+)?
ident [a-zA-Z][a-zA-Z0-9_#]*
oparth [+]|[-]|[*]|[/]
oprel <|>|<>|<=|>=|==|!=
motcle if|else|while
sp [[:space:]]
chaine \"[^\"\n]*\"?
commentaire #[^#]*#?

%%
{entier} {return entier;}
{motcle} {return motcle;}
{chaine} {return chaine;}
{oparth} {return oparth;}
{oprel} {return oprel;}
{ident} {return ident;}
{reel} {return reel;}
{exposant} {return exposant;}
{commentaire} {return commentaire;}
[ \t\n] ;
. {printf("%s caractere pas reconnu ",yytext); } // return SyntaxError
%%
int yywrap(void) {return 1;}

// int main()
// {
// yylex() ;
// return 0;
// }