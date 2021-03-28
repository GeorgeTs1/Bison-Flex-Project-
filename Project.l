%{
#include <stdio.h>
#include <string.h>
#include "project.tab.h"
void showError();
int linenum = 1;
%}


numbers            [0-9]+
letters            [a-z]
text               (" ")*[a-z][a-z0-9]*
new_line           [\n] 
vars               "VARS"(" ")*("CHAR"|"INTEGER")(" ")*[a-z][a-z0-9]*("["[0-9]+"]")* 
declaration_f_par  (" ")*"("("VARS"(" ")*("CHAR"|"INTEGER")(" ")*[a-z][a-z0-9]*("[""]")*(",")*)*")" 
declaration_f_var  ("VARS"(" ")*("CHAR"|"INTEGER")(" ")*[a-z][a-z0-9]*("["[0-9]+"]")*(","(" ")*[a-z][a-z0-9]*("["[0-9]+"]")*)*";")*
return_var         (" ")*(([a-z][a-z0-9]*)|([0-9]+))";"
function           [a-z][a-z0-9]*"("([a-z][a-z0-9]*(",")*)*")"";"
expression_var     (([a-z][a-z0-9]*)|([0-9]))(("+"|"-"|"\"|"*"|"^")([a-z][a-z0-9]*)|([0-9])|([a-z][a-z0-9])*"("("VARS"(" ")*("CHAR"|"INTEGER")(" ")*[a-z][a-z0-9]*("[""]")*)*")") 
assignment         [a-z][a-z0-9]*(" ")*"="(" ")*(([a-z][a-z0-9]*)|("\""([a-z0-9A-Z" "])*"\"")|([0-9])|([a-z][a-z0-9]*"("([a-z][a-z0-9]*("["[0-9]"]")*(",")*)*")"))(" ")*(("+"|"-"|"/"|"*"|"^")(" ")*(([a-z][a-z0-9]*)|([0-9])|([a-z][a-z0-9]*"("([a-z][a-z0-9]*("[]")*(",")*)*")")))*";"
condition          "("(([a-z][a-z0-9]*)|[0-9])("<"|">"|"!="|"=="|"AND"|"OR")([a-z][a-z0-9]*)|[0-9]))")"
for_command        "FOR"(" ")*([a-z][a-z0-9]*)(" ")*":="[0-9]+(" ")*"TO"(" ")*[0-9]+(" ")*"STEP"(" ")*[0-9]+
while_command      "WHILE"[condition]
if_command         "IF"[condition]"THEN"
elseif_command     "ELSEIF"[condition]
switch_command     "SWITCH""("[expression_var]")"
case_command       "CASE"+"("[expression_var]")"":"
default_command    "DEFAULT"":" 
print_command      "PRINT""(""""[text]"""("["var_name"]")*")"
break_command      "BREAK;"
   

%%

"PROGRAM"           {return(PROGRAM);}
{text}              {return(STRING);}
{new_line}          {linenum++; return(NEW_LINE);}
"FUNCTION"          {return(FUNCTION);}             
{declaration_f_par} {sscanf(yytext, "%s", yylval.variables); return(F_PARAMETERS);}
{declaration_f_var} {sscanf(yytext, "%s", yylval.variables); return(F_DECLARATIONS);} 
{vars}              {return(VARS);}
"RETURN"            {return(RETURN);}
{return_var}	     {return(RETURN_VAR);}
"END_FUNCTION"      {return(END_FUNCTION);}
"STARTMAIN"         {return(STARTMAIN);}
{assignment}        {sscanf(yytext, "%s", yylval.assignment); return(ASSIGNMENT);}
{while_command}	  {return(WHILE_COMMAND);}
"END_WHILE"         {return(END_WHILE);}
{for_command}	     {return(FOR_COMMAND);}
"END_FOR"           {return(END_FOR);}
{if_command}        {return(IF_COMMAND);}
{elseif_command}    {return(ELSEIF_COMMAND);}
"ELSE"	           {return(ELSE);}
"ENDIF"             {return(ENDIF);}
{switch_command}    {return(SWITCH_COMMAND);}
{case_command}      {return(CASE_COMMAND);}
"DEFAULT"           {return(DEFAULT);}
"ENDSWITCH"         {return(ENDSWITCH);}
{print_command}     {return(PRINT_COMMAND);}
{break_command}	  {return(BREAK_COMMAND);}
"ENDMAIN"           {return(ENDMAIN);}
.                   {showError();return(OTHER);}

%%

void showError(){
    printf("Other input");
}
