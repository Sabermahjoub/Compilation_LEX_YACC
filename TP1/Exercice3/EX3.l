%{
#include<stdio.h>
#include <string.h>
%}

nom [A-Z][a-z]*
prenoms ([a-z]+[[:space:]])+
tel ([0-9][0-9][[:space:]]){4}[0-9][0-9]

%%
{nom}[[:space:]]{prenoms}@[[:space:]]{tel}[[:space:]]*  { printf("ACCEPTE ! \n"); }
.* { printf("REFUSE \n"); }
%%
int yywrap() {return 1;}

int main(int argc, char *argv[]){
yylex();
return 0;
}