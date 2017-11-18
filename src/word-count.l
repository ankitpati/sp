%{
    size_t nchar, nword, nline;
%}

%%

\n {
    ++nline;
    ++nchar;
}

[^ \t\v\f\n]+ {
    ++nword;
    nchar += yyleng;
}

. { /* redundant */
    ++nchar;
}

%%

int yywrap()
{
    return 1;
}

int main(int argc, char **argv)
{
    if (argc != 2) {
        fprintf(stderr, "Usage:\n\tword-count <filename>\n");
        exit(1);
    }

    if (!(yyin = fopen(argv[1], "r"))) {
        perror("word-count");
        exit(errno);
    }

    yylex();

    printf("%7zu\t%7zu\t%7zu\t%s\n", nline, nword, nchar, argv[1]);

    return 0;
}
