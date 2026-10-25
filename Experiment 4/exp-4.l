%{
/* Name: Urwashi Dhawas | PRN: 24070521154 */
#include "y.tab.h"
#include <stdlib.h>
%}

%%
[0-9]+ {
    yylval = atoi(yytext);
    return NUM;
}

[ \t\r\n]+ {
    /* Ignore whitespace */
}

. {
    return yytext[0];
}
%%

int yywrap()
{
    return 1;
}
