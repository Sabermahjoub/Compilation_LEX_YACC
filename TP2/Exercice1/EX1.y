%{
    #include<stdio.h>
    int S=0;
    int P=1;
    int sousop;
    int divop;
%}
%error-verbose

%token FIN;
%token SOM;
%token PROD;
%token SOUS;
%token DIV;
%token NB;


%%
liste : FIN {printf("correct! Somme = %d , Produit = %d, soustraction = %d , division = %.2f \n",S,P,sousop,divop);}
        |SOM listesom'.'liste
        |PROD listeprod'.'liste
        |SOUS listesous'.'liste
        |DIV listediv'.'liste;
listesom: NB{S+=$1;} | listesom','NB{S+=$3;} ;
listeprod: NB{P*=$1;} |listeprod','NB{P*=$3;} ;
listesous: NB{sousop=$1;} | listesous','NB {sousop-=$3;};
listediv: NB{divop=$1;} | listediv','NB {divop=divop/$3;};
%%
int yyerror (char * s){
    printf("%s",s);
    return 0;
}
int main() {
    yyparse();
    getchar();
    return 0;
}