#include<stdio.h>
#include<stdlib.h>
#include<string.h>

char *my_strdup(const char *s)
{
    if(s==NULL) return NULL;
    size_t len = strlen(s);
    char *t = (char*)malloc(len+1);
    memcpy(t, s, len);
    t[len]='\0';
    return t;
}
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

void print_query_result(char * query_type, int num_selected_fields, int num_inserted_values, int num_columns){
    printf("********************************************************\n");
    printf("Query TYPE : %s \n",query_type);
    if(strcmp(query_type,"SELECT")==0){
        printf("Number of selected fields: ");
        if(num_selected_fields == -1) printf("all \n");
        else printf("%d \n",num_selected_fields);
    }else if(strcmp(query_type,"INSERT")==0){
        if(num_columns!=0 && num_columns<num_inserted_values){
            printf("ERROR : Number of values provided exceeds the number of columns specified \n");
        }else if(num_columns!=0 && num_columns>num_inserted_values){
            printf("ERROR : Number of columns specified exceeds the number of values provided \n");
        }
        else printf("Number of inserted fields: %d \n", num_inserted_values);
    }
}