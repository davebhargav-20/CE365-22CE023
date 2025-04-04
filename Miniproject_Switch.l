%{
#include <stdio.h>
#include <string.h>
#include "Miniproject_Switch.tab.h"

int line_num = 1;
%}

%%
"switch"        { return SWITCH; }
"case"          { return CASE; }
"default"       { return DEFAULT; }
"break"         { return BREAK; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
":"             { return COLON; }
";"             { return SEMICOLON; }
"("             { return LPAREN; }
")"             { return RPAREN; }

[0-9]+          { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.id = strdup(yytext); return IDENTIFIER; }

[ \t]           { /* ignore whitespace */ }
\n              { line_num++; }
"//".*\n        { line_num++; /* ignore single line comments */ }
"/*"            { 
                  char c, prev = 0;
                  while ((c = input()) != 0) {
                    if (c == '/' && prev == '*')
                      break;
                    if (c == '\n')
                      line_num++;
                    prev = c;
                  }
                }

.               { return yytext[0]; }
%%

int yywrap() {
    return 1;
}