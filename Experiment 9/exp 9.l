%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%
[0-9]+(\.[0-9]+)? {
    yylval = atof(yytext);
    return NUMBER;
}

"++"    { return INC; }
"--"    { return DEC; }
"+"     { return '+'; }
"-"     { return '-'; }
"*"     { return '*'; }
"/"     { return '/'; }
"%"     { return '%'; }
"^"     { return '^'; }
"("     { return '('; }
")"     { return ')'; }

[ \t]+  ;
\n      { return '\n'; }
.       { return INVALID; }
%%

int yywrap(void)
{
    return 1;
}
