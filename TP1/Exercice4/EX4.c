#include <stdio.h>
#include "EX4.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

//char *tokens[10] = {NULL,"command","object","identifier","opO","data_type","PK","virg","opF","endCommand"} ;

int main(void) {
    FILE *output_file = fopen("Resultats.txt", "w");
    if (output_file == NULL) {
        fprintf(stderr, "Erreur lors de l'ouverture du fichier.\n");
        return 1;
    }
    int ntoken,vtoken; 
    ntoken = yylex();
    int test=0;
    while(ntoken) {
        //printf ("%s \n", tokens[ntoken]);
        switch(ntoken) {
            case opF:
                fprintf(output_file, "%s : \t  ) \n", yytext);
                vtoken= yylex();

                if (vtoken == endCommand) {
                    printf("CREATE TABLE IS SUCCESSFULL ! ");
                    return 0;                    
                }
                else {
                    printf("SYNTAX ERROR, ';' is missed  ");
                    return 1;
                }
            case data_type:
                fprintf(output_file, "%s : \t  DataType \n", yytext);
                vtoken= yylex();

                if (vtoken == PK) {
                    fprintf(output_file, "%s : \t  PRIMARY KEY \n", yytext);
                    int vtoken_2= yylex();
                    if (vtoken_2 == opF) {
                        ntoken=vtoken_2;
                        continue;
                    }
                    else if (vtoken_2==virg){
                        fprintf(output_file, "%s : \t  comma \n", yytext);
                        ntoken = yylex();
                        continue;
                    }
                    else //if (vtoken_2!=PK && vtoken_2 != virg) 
                    {
                        printf("EXPECTED VIRG AFTER PRIMARY KEY CONSTRAINT, BUT RECEIVED : %s ",yytext);
                        return 1;
                    }
                    ntoken=vtoken_2;
                    continue;
                }
                else if (vtoken == virg) {
                    fprintf(output_file, "%s : \t  COMMA \n", yytext);
                    ntoken= yylex();
                    continue;
                }
                else if (vtoken == opF) {
                    ntoken=vtoken;
                    continue;
                }
                else{
                    printf("EXPECTED VIRG AFTER DATA_TYPE, BUT RECEIVED : %s",yytext);
                    return 1;
                }
                break;        
            case identifier:

                fprintf(output_file, "%s : \t  IDENTIFIER \n", yytext);
                vtoken= yylex();

                if (vtoken != data_type) {
                        printf("Expected DATA_TYPE but received : %s ",yytext);
                        return 1;
                }
                break;              
            case opO:
                vtoken= yylex();
                if (vtoken != identifier) {
                        printf("Expected IDENTIFIER but received : %s ",yytext);
                        return 1;
                }
                break;                
            case object:
                fprintf(output_file, "%s : \t  TABLE \n", yytext);
                vtoken= yylex();
                if (vtoken != identifier) {
                    printf("Expected IDENTIFIER but received : %s ",yytext);
                    return 1;
                }
                else {
                    fprintf(output_file, "%s : \t  IDENTIFIER \n", yytext);
                    int vtoken_2= yylex();
                    if (vtoken_2 != opO) {
                        printf("Expected '(' but received : %s ",yytext);
                        return 1;
                    }
                    fprintf(output_file, "%s : \t  ( \n", yytext);

                    ntoken=vtoken_2;
                    continue;
                }
                break;
            case command: 
                fprintf(output_file, "%s : \t  CREATE \n", yytext);
                vtoken= yylex();
                if (vtoken != object) {
                    printf("Expected TABLE but received : %s ",yytext);
                    return 1;
                }
                break;
        };
        ntoken=vtoken;
    };
    fclose(output_file);
    return 0;
}