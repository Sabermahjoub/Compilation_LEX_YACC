%{
#include "sql_parser.tab.h"

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <malloc.h>


int yylex();

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

/*
%token FCOUNT
%token FSUM
*/

%%

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
    ;

column_definition_list:
    column_definition PRIMARY_KEY 
    | column_definition VIRG column_definition_list 
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
    ;

select_list:
    IDENTIFIER VIRG select_list  
    | IDENTIFIER   
    | ASTR             
    ;

table_reference:
    IDENTIFIER ; 

update_statement:
    UPDATE table_reference SET set_clause opt_where
    ;

delete_statement:
    DELETE FROM table_reference opt_where
    ;

insert_statement:
    INSERT INTO table_reference opt_column_list VALUES value_list
    ;

column_list:
    IDENTIFIER VIRG column_list
    | IDENTIFIER
    ;

value_list:
    BracO values BracC
    ;

values:
    literal VIRG values
    | literal
    ;

literal:
    INTNUM
    | FLOATNUM
    | STRING
    ;

set_clause:
    SET set_list
    ;

set_list:
    set_item VIRG set_list
    | set_item
    ;

set_item:
    IDENTIFIER '=' expression
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
    | ORDER BY column_list
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