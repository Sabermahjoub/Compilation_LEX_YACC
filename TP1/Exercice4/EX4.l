%{
#include <stdio.h>
#include <string.h>
#include "EX4.h"

%}
identifier [a-zA-Z][a-zA-Z0-9_#]*
opO [(]
opF [)]
sp [[:space:]]
number [0-9]+
virg [,]
string varchar{opO}{number}{opF}
data_type (i|I)(n|N)(t|T)|DATE|{string}|{number}
command (c|C)(r|R)(E|e)(A|a)(T|t)(E|e) 
object (T|t)(A|a)(B|b)(L|l)(E|e) 
PK PRIMARY{sp}+KEY
champ {identifier}{sp}*{data_type}{sp}*{PK}?{sp}*
endCommand [;]

%%
{command} return command;
{object} return object;
{PK} return PK;
{opO} return opO;
{opF} return opF;
{data_type} return data_type;
{identifier} return identifier;
{endCommand} return endCommand;
{virg} return virg;
[ \t\n] ;
. printf("%s caractere pas reconnu ",yytext); 
%%
int yywrap(void) {return 1;}

// int main(int argc, char *argv[]){
// yylex();
// return 0;
// }