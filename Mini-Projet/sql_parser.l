%option noyywrap nodefault yylineno case-insensitive
%{
#include "utils.h"
#include "sql_parser.tab.h"

#include <stdarg.h>
#include <string.h>
#include <stdio.h>


extern int yylex();
int oldstate;

%}

%s BTWMODE

%%
<BTWMODE>AND { BEGIN INITIAL; return AND; }
AND { return ANDOP; }
AS { return AS; }
ASC { return ASC; }
DESC { return DESC; }
DELETE { return DELETE; }
FROM { return FROM; }
GROUP { return GROUP; }
IN { return IN; }
INSERT { return INSERT; }
INTO { return INTO; }
LIKE { return LIKE; }
LIMIT { return LIMIT; }
NOT { return NOT; }
OR { return OR; }
ORDER { return ORDER; }
BY { return BY; }
SELECT { return SELECT; }
SET { return SET; }
UPDATE { return UPDATE; }
VALUES { return VALUES; }
WHERE { return WHERE; }
CREATE { return CREATE; }
TABLE { return TABLE; }
INTEGER { return INTEGER; }
FLOAT { return FLOAT; }
VARCHAR { return VARCHAR; }
PRIMARY[[:space:]]KEY { return PRIMARY_KEY; }
[,] { return VIRG; }
[(] { return BracO; }
[)] { return BracC; }
[*] { return ASTR; }
[;] { return END; }
[=] { return EQUAL; }





-?[0-9]+ { yylval.intval=atoi(yytext); return INTNUM; }
-?[0-9]+"."[0-9]* |
-?"."[0-9]+ { yylval.floatval=atof(yytext); return FLOATNUM; }


'(\\.|''|[^'\n])*' { 
        yylval.strval = my_strdup(yytext+1); 
        yylval.strval[yyleng-2]=0; 
        return STRING; 
    }
'(\\.|[^'\n])*$ { printf("Unterminated string %s", yytext); }



">=" { yylval.subtok=">="; return COMPARISON; }
">" { yylval.subtok=">"; return COMPARISON; }
"<=" { yylval.subtok="<="; return COMPARISON; }
"<" { yylval.subtok="<"; return COMPARISON; }
"!=" |
"<>" { yylval.subtok="!="; return COMPARISON; }




[A-Za-z][A-Za-z0-9_]* { 
    yylval.strval = my_strdup(yytext);
    return IDENTIFIER; 
}


#.* ;
"--"[ \t].* ;


[ \t\n] 
. { printf("Unrecognized character %c ", *yytext); }

%%