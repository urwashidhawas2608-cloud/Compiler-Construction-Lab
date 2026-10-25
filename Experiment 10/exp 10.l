%{
#include "y.tab.h"
%}

%%
"for"                       { return FOR; }
"("                         { return LPAREN; }
")"                         { return RPAREN; }
"{"                         { return LBRACE; }
"}"                         { return RBRACE; }
";"                         { return SEMICOLON; }
"="                         { return ASSIGN; }
"++"                        { return INC; }
"--"                        { return DEC; }

"<="|">="|"=="|"!="|"<"|">" { return RELOP; }
"+"|"-"                     { return ADDOP; }
"*"|"/"|"%"                 { return MULOP; }

[0-9]+                      { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*      { return IDENTIFIER; }

[ \t\r\n]+                  ;
.                           { return INVALID; }
%%

int yywrap(void)
{
    return 1;
}
