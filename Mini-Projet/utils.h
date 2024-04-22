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
