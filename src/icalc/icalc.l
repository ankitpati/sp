%{
#include "y.tab.h"

void yyerror(char *);
%}

%%

[a-zA-Z_] {
    yylval = *yytext;
    return VARIABLE;
}

[0-9]+ {
    yylval = atoi(yytext);
    return INTEGER;
}

[-+*/=()\n]     return *yytext;
[ \t\v\f\n]+    ;
.               yyerror("invalid character");

%%

int yywrap()
{
    return 1;
}

/* OUTPUT

$ yacc -d icalc.y && lex icalc.l && cc -o icalc lex.yy.c y.tab.c && ./icalc
t = 43
b = 5
l = t * b
l
215

*/
