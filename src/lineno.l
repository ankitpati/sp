%{
#include <errno.h>
%}

%%

^.*\n   fprintf(yyout, "%07d\t%s", yylineno++, yytext);

%%

int yywrap()
{
    return 1;
}

int main(int argc, char **argv)
{
    if (argc != 3) {
        fprintf(stderr, "Usage:\n\tlineno <input file> <output file>\n");
        exit(1);
    }

    if (!(yyin = fopen(argv[1], "r")) || !(yyout = fopen(argv[2], "w"))) {
        perror("lineno");
        exit(errno);
    }

    yylex();
    return 0;
}

