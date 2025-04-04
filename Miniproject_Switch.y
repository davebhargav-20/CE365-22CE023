%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int line_num;
extern FILE *yyin;
int error_count = 0;

void yyerror(const char *s);
int yylex();
%}

%union {
    int num;
    char *id;
}

%token SWITCH CASE DEFAULT BREAK
%token LBRACE RBRACE COLON SEMICOLON LPAREN RPAREN
%token <num> NUMBER
%token <id> IDENTIFIER

%%

program:
    /* empty */
    | program switch_statement
    ;

switch_statement:
    SWITCH LPAREN expression RPAREN LBRACE case_list RBRACE
    ;

expression:
    IDENTIFIER
    | NUMBER
    ;

case_list:
    /* empty */
    | case_list case_statement
    | case_list default_statement
    ;

case_statement:
    CASE NUMBER COLON statement_list
    ;

default_statement:
    DEFAULT COLON statement_list
    ;

statement_list:
    /* empty */
    | statement_list statement
    ;

statement:
    simple_statement SEMICOLON
    | BREAK SEMICOLON
    | compound_statement
    | switch_statement
    ;

simple_statement:
    IDENTIFIER
    | IDENTIFIER '=' expression
    ;

compound_statement:
    LBRACE statement_list RBRACE
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error at line %d: %s\n", line_num, s);
    error_count++;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        return 1;
    }

    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        fprintf(stderr, "Cannot open file %s\n", argv[1]);
        return 1;
    }

    yyin = input_file;
    yyparse();

    if (error_count == 0) {
        printf("Switch statement syntax is valid!\n");
    } else {
        printf("Found %d syntax error(s) in the switch statement.\n", error_count);
    }

    fclose(input_file);
    return 0;
}