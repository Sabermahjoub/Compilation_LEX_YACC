%{
#include "sql_parser.tab.h"

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <malloc.h>


int yylex();

int num_selected_fields = 0;  /* Number of selected fields in the SELECT statement */
int num_inserted_values =0 ;  /* Number of inserted fields in the INSERT statement */
int num_columns=0;
char * query_type = NULL ;  

%}

%union {
    int intval;
    double floatval;
    char *strval;
    char* subtok;
}

/*tokens with values*/
%token <strval> IDENTIFIER
%token <strval> STRING
%token <intval> INTNUM
%token <floatval> FLOATNUM
    
/* operators associativity */
%right ASSIGN
%left OR
%left XOR
%left ANDOP
%nonassoc IN IS LIKE REGEXP
%left NOT '!'
%left BETWEEN
%left <subtok> COMPARISON /* = <> < > <= >= <=> */
%left '|'
%left '&'
%left '+' '-'
%left '*' '/' '%' MOD
%left '^'

/*tokens*/
%token AND
%token AS
%token ASC
%token BY
%token COUNT
%token DELETE
%token DESC
%token FROM
%token GROUP
%token IN
%token INSERT
%token INTO
%token LIKE
%token LIMIT
%token NOT
%token OR
%token ORDER
%token SELECT
%token SET
%token SUM
%token UPDATE
%token VALUES
%token WHERE
%token CREATE
%token TABLE
%token INTEGER
%token FLOAT
%token VARCHAR
%token PRIMARY_KEY
%token VIRG
%token BracO
%token BracC
%token ASTR
%token END
%token EQUAL

/*
%token FCOUNT
%token FSUM
*/

%%
sql_queries: sql_query | sql_query sql_queries ;

sql_query: 
    sql_statement END 
    { print_query_result(query_type, num_selected_fields, num_inserted_values, num_columns);
    num_selected_fields=0;
    num_inserted_values=0;
    num_columns=0;
    }; 

sql_statement:
    select_statement
    | update_statement
    | delete_statement
    | insert_statement
    | create_table_statement 
    ;

/*CREATE TABLE*/

create_table_statement:
    CREATE TABLE table_reference BracO column_definition_list BracC
    {query_type="CREATE TABLE";}
    ;

column_definition_list:
    column_definition PRIMARY_KEY 
    | column_definition VIRG column_definition_list 
    | column_definition_list VIRG column_definition 
    | column_definition 
    ;

column_definition:
    IDENTIFIER data_type 
    ;

data_type:
    INTEGER
    | FLOAT
    | VARCHAR BracO INTNUM BracC
    ;


/*SELECT*/ 

select_statement:
    SELECT select_list FROM table_reference opt_where opt_group_by opt_order_by opt_limit
    {query_type="SELECT";}
    ;

select_list:
    IDENTIFIER {num_selected_fields++;} VIRG select_list  
    | IDENTIFIER  {num_selected_fields++;} 
    | ASTR  {num_selected_fields=-1;}
    ;

table_reference:
    IDENTIFIER ; 

/*update*/ 
update_statement:
    UPDATE table_reference SET set_clause opt_where
    {query_type= "UPDATE";}
    ;
set_clause:
    set_list
    ;

set_list:
    set_item VIRG set_list
    | set_item
    ;

set_item:
    IDENTIFIER EQUAL expression
    | IDENTIFIER EQUAL literal
    ;

/*delete*/
delete_statement:
    DELETE FROM table_reference opt_where
    {query_type = "DELETE";}
    ;

/*insert*/ 
insert_statement:
    INSERT INTO table_reference opt_column_list VALUES value_list
    {query_type = "INSERT";}
    ;

column_list:
    IDENTIFIER {num_columns++;} VIRG column_list
    | IDENTIFIER  {num_columns++;}
    ;

value_list:
    BracO values BracC
    ;

values:
    literal {num_inserted_values++;} VIRG values
    | literal {num_inserted_values++;}
    ;

literal:
    INTNUM
    | FLOATNUM
    | STRING
    ;



/*OPTIONAL*/ 

opt_column_list:
    | BracO column_list BracC
    ;

opt_where:
    | WHERE expression
    ;

opt_group_by:
    | GROUP BY column_list
    ;

opt_order_by:
    | ORDER BY column_list  order_type
    ;
order_type : 
    ASC 
    | DESC 
    ; 

opt_limit:
    | LIMIT INTNUM
    ;


expression:
    comparison_expression
    | logical_expression
    | BracO expression BracC
    ;

comparison_expression:
    term COMPARISON term
    |term EQUAL term
    ;

logical_expression:
    expression AND expression
    | expression OR expression
    | NOT expression
    ;

term:
    literal
    | IDENTIFIER
    ;


%%
int main() {
    yyparse();
    getchar();
    return 0;
}