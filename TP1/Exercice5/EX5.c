#include <stdio.h>
#include <string.h>
#include "EX5.h"

extern int yylex();
extern int yylineno;
extern char* yytext;


int main(void) {
    
    int ntoken,vtoken; 
    ntoken = yylex();
    while(ntoken) {
        //printf ("%s \n", tokens[ntoken]);
        switch(ntoken) {
            case commentaire:
                if (strlen(yytext) > 0 && yytext[strlen(yytext) - 1] != '#') {
                    printf("\033[1;31m"); // Set text color to red
                    printf("SYNTAX ERROR *** [MISSING #] at the end of the comment !");
                    printf("\033[0m"); // Reset text color to default
                    return 1;
                } else if (strlen(yytext)>0 && yytext[strlen(yytext)-1] == '#') {
                    printf("UN COMMENTAIRE ");
                    ntoken= yylex();
                    continue;
                }
                break;
            case entier:
                vtoken= yylex();
                if(vtoken==ident){
                    printf("\033[1;31m"); // Set text color to red
                    printf("IDENTIFICATEUR MAL FORME ! ");
                    printf("\033[0m"); // Reset text color to default
                    return 1;
                }
                else {
                    printf("un entier : %s", yytext);
                }
                break;        
            case ident:
                vtoken= yylex();
                printf("UN IDENTIFICATEUR : %s",yytext);
                break;              
        };
        ntoken=vtoken;
    };
    return 0;
}