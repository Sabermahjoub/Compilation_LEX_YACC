%{
#include<stdio.h>
#include <string.h>
int nbChar = 0;
int nbLignes = 0;
int somme = 0;
int nbMots = 0;
%}

%%
[a-zA-Z#]+  { nbMots++; nbChar += yyleng; }
[0-9]+     { nbMots++; nbChar += yyleng; somme += atoi(yytext); }
\n         { nbLignes++; }
.          { nbChar++; }
%%
int yywrap() {return 1;}

int main(int argc, char *argv[]){

FILE *output_file = fopen("Resultats.txt", "w");
        if (output_file == NULL) {
            fprintf(stderr, "Erreur lors de l'ouverture du fichier.\n");
            return 1;
        }
        
        yylex();
        
        fprintf(output_file, "Nombre de mots: %d\n", nbMots);
        fprintf(output_file, "Nombre de lignes: %d\n", nbLignes);
        fprintf(output_file, "Nombre de caractères: %d\n", nbChar);
        fprintf(output_file, "Somme des nombres lus: %d\n", somme);
        
        fclose(output_file);
        
        printf("Les résultats ont ete ecrits dans le fichier 'Resultats.txt'.\n");
    return 0;
}



// Get-Content data.txt | ./output