%{
#include <stdio.h>

int yylex();
void yyerror(char *);

int sym[256];
%}

%token INTEGER VARIABLE
%left '+' '-'
%left '*' '/'

%%

program:
    program statement '\n'
    | %empty
    ;

statement:
    expr                    { printf("%d\n", $1); }
    | VARIABLE '=' expr     { sym[$1] = $3;       }
    ;

expr:
    INTEGER
    | VARIABLE              { $$ = sym[$1]; }
    | expr '+' expr         { $$ = $1 + $3; }
    | expr '-' expr         { $$ = $1 - $3; }
    | expr '*' expr         { $$ = $1 * $3; }
    | expr '/' expr         { $$ = $1 / $3; }
    | '(' expr ')'          { $$ = $2;      }
    ;

%%

void yyerror(char *msg)
{
    fprintf(stderr, "%s\n", msg);
}

int main()
{
    yyparse();
    return 0;
}
