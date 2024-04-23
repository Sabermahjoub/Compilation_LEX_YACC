#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "EX5.h"

extern int yylex();
extern int yylineno;
extern char* yytext;


int main(void) {
    FILE *output_file = fopen("Resultats.txt", "w");
    if (output_file == NULL) {
        fprintf(stderr, "Erreur lors de l'ouverture du fichier.\n");
        return 1;
    }
    int ntoken,vtoken; 
    ntoken = yylex();
    while(ntoken) {
        //printf ("%s \n", tokens[ntoken]);
        switch(ntoken) {

            case motcle:
                printf("UN MOTCLE : %s \t",yytext);
                fprintf(output_file, "UN MOTCLE : \t%s : \n", yytext);
                vtoken= yylex();
                break;      
            case entier:
                printf("UN ENTIER : %s \t",yytext);
                fprintf(output_file, "UN ENTIER : \t%s : \n", yytext);
                vtoken= yylex();
                break;      
            case reel:
                printf("UN real : %s \t",yytext);
                fprintf(output_file, "UN REAL : \t%s : \n", yytext);
                vtoken= yylex();
                break;    
            case exposant:
                if (strlen(yytext) > 0 && yytext[strlen(yytext) - 1] == 'e' ){
                    printf("\033[1;31m"); // Set text color to red
                    printf("SYNTAX ERROR *** [MISSING DIGITS] Exposant attendu !");
                    printf("\033[0m"); // Reset text color to default
                    return 1;
                } else if (strlen(yytext)>0 && yytext[strlen(yytext)-1] != 'e') {
                    printf("UN EXPOSANT %s \t", yytext);
                    fprintf(output_file, "EXPOSANT : \t%s : \n", yytext);
                    ntoken= yylex();
                    continue;
                }
                break;
            case oprel:
                printf("OP-Log : %s \t ",yytext);
                fprintf(output_file, "OP LOG : \t%s : \n", yytext);
                vtoken= yylex();
                break;   
            case oparth:
                printf("OP-Arith : %s \t",yytext);
                fprintf(output_file, "OP ARITH : \t%s : \n", yytext);
                vtoken= yylex();
                break;   
            case chaine:
                if (strlen(yytext) > 0 && yytext[strlen(yytext) - 1] != '"') {
                    printf("\033[1;31m"); // Set text color to red
                    printf("SYNTAX ERROR *** [MISSING \"] at the end of the string !");
                    printf("\033[0m"); // Reset text color to default
                    return 1;
                } else if (strlen(yytext)>0 && yytext[strlen(yytext)-1] == '"') {
                    printf("UNE CHAINE ");
                    fprintf(output_file, "CHAINE : \t%s : \n", yytext);
                    ntoken= yylex();
                    continue;
                }
                break;
            case commentaire:
                if (strlen(yytext) > 0 && yytext[strlen(yytext) - 1] != '#') {
                    printf("\033[1;31m"); // Set text color to red
                    printf("SYNTAX ERROR *** [MISSING #] at the end of the comment !");
                    printf("\033[0m"); // Reset text color to default
                    return 1;
                } else if (strlen(yytext)>0 && yytext[strlen(yytext)-1] == '#') {
                    printf("UN COMMENTAIRE ");
                    fprintf(output_file, "COMMENTAIRE : \t%s : \n", yytext);
                    ntoken= yylex();
                    continue;
                }
                break;
            case ident:
                printf("UN IDENTIFICATEUR : %s \t",yytext);
                fprintf(output_file, "UN IDENTIFICATEUR : \t%s : \n", yytext);
                vtoken= yylex();
                break;              
        };
        ntoken=vtoken;
    };
    return 0;
}