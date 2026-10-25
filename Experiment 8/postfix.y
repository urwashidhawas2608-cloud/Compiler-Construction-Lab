%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER
%start input

%%
input:
      /* empty */
    | input line
    ;

line:
      '\n'
    | expr '\n' { printf("Result = %d\n", $1); }
    ;

expr:
      NUMBER        { $$ = $1; }
    | expr expr '+' { $$ = $1 + $2; }
    | expr expr '-' { $$ = $1 - $2; }
    | expr expr '*' { $$ = $1 * $2; }
    | expr expr '/' {
        if ($2 == 0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $2;
        }
      }
    ;
%%

void yyerror(const char *s)
{
    fprintf(stderr, "Error: %s\n", s);
}

int main(void)
{
    printf("Enter postfix expressions (e.g., 5 5 *):\n");
    return yyparse();
}
