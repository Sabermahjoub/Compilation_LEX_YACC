%{

%}

%token command;
%token table;
%token identifier;
%token parOuv;
%token parFerm;
%token number;
%token varchar;
%token date;
%token PK;
%token fin;
%token virg;
%token INT;

%%
input : command table {printf("first ok ");};
createSQL: request fin {printf("Request Create is Successfull ! ");};
request: command table identifier parOuv champ parFerm {printf("herrre");};
champ: identifier datatype constraint virg champ
    | identifier datatype constraint ;
datatype : INT | varchar | date ;
constraint:
        | PK;
%%
yyerror (char * s){
    printf("%s",s);
    return 0;
}

int main() {
    yyparse();
    getchar();
    return 0;
}