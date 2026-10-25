%{
#define YYSTYPE double
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER
%token INC DEC INVALID

%left '+' '-'
%left '*' '/' '%'
%right '^'
%right UMINUS

%start input

%%
input:
      /* empty */
    | input line
    ;

line:
      expr '\n'
      {
          printf("Result = %g\n", $1);
      }
    | '\n'
    | error '\n'
      {
          printf("Error: Invalid expression. Please try again.\n");
          yyerrok;
      }
    ;

expr:
      NUMBER
      {
          $$ = $1;
      }
    | expr '+' expr
      {
          $$ = $1 + $3;
      }
    | expr '-' expr
      {
          $$ = $1 - $3;
      }
    | expr '*' expr
      {
          $$ = $1 * $3;
      }
    | expr '/' expr
      {
          if ($3 == 0)
          {
              yyerror("Division by zero");
              $$ = 0;
          }
          else
          {
              $$ = $1 / $3;
          }
      }
    | expr '%' expr
      {
          if ((int)$3 == 0)
          {
              yyerror("Modulo by zero");
              $$ = 0;
          }
          else
          {
              $$ = (int)$1 % (int)$3;
          }
      }
    | expr '^' expr
      {
          $$ = pow($1, $3);
      }
    | '-' expr %prec UMINUS
      {
          $$ = -$2;
      }
    | '(' expr ')'
      {
          $$ = $2;
      }
    | INC expr
      {
          $$ = $2 + 1;
      }
    | DEC expr
      {
          $$ = $2 - 1;
      }
    | expr INC
      {
          $$ = $1 + 1;
      }
    | expr DEC
      {
          $$ = $1 - 1;
      }
    ;
%%

void yyerror(const char *s)
{
    fprintf(stderr, "Error: %s\n", s);
}

int main(void)
{
    printf("SDT DESK CALCULATOR\n");
    printf("Operators: + - * / %% ^ ++ --\n");
    printf("Press Ctrl+D to exit.\n");

    yyparse();
    return 0;
}
