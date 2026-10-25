%{
/* Name: Urwashi Dhawas | PRN: 24070521154 */
#include <stdio.h>

int yylex(void);
int yyerror(const char *s);
%}

%token NUM
%left '+' '-'
%left '*' '/'
%right UMINUS

%%
input:
      expression '\n'
    | expression
    ;

expression:
      expression '+' expression
    | expression '-' expression
    | expression '*' expression
    | expression '/' expression
    | '(' expression ')'
    | '-' expression %prec UMINUS
    | NUM
    ;
%%

int yyerror(const char *s)
{
    printf("Invalid Expression\n");
    return 0;
}

int main()
{
    printf("Enter Expression: ");

    if (yyparse() == 0)
        printf("Valid Expression\n");

    return 0;
}
