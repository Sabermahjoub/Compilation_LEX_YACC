%{
%}
%error-verbose

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

createSQL: requests fin;
requests: request
        | requests fin request;
request: command table identifier parOuv champ parFerm { printf("Request Create is Successfull ! "); };
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
    return 0;
}