%{
#include "y.tab.h"

void yyerror(char *);
%}

%%

[0-9]+ {
    yylval = atoi(yytext);
    return INTEGER;
}

[-+\n]          return *yytext;
[ \t\v\f\n]+    ; /* ignore whitespace */
.               yyerror("invalid character");

%%

int yywrap()
{
    return 1;
}
