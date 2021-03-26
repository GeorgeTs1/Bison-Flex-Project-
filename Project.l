%{

#include <stdio.h>
#include <string.h>
#include "project.tab.h"
void showError();
%}


numbers [0-9]+
var_name  [a-z][a-z0-9]*
prog_name [a-z][a-z0-9]*
func_name [a-z][a-z0-9]*
text  [a-z][a-z0-9]*
new_line [\n]
var  ["VARS"] + ( [char] | [int] ) + [var_name] + [table]* 
char ["CHAR"]
int  ["INTEGER"]
table ["["] + [numbers] + ["]"]
declaration_f_par  "(" + ([var] + [","])+ ")"
declaration_f_var  [var] + (","+[var])* + ";"
expression_var    (([name]|[numbers]) + ( ("+" | "-" | "\" | "*"|"^") + ([name]|[numbers])*) 
assignment         [var_name] + "=" [expression_var] + ";"
condition         "(" + ( ([var_name]|[numbers]) + ("<" | ">" | "!=" | "=="|"AND" | "OR") +  ([var_name]|[numbers])) + ")"
for_assignment     [var_name] + ":=" [expression_var]
for_command        "FOR" + [for_assignment] + "TO" + [numbers] + "STEP" + [numbers]
while_command      "WHILE" + [condition]
if_command         "IF" + [condition] + "THEN"
elseif_command     "ELSEIF" + [condition]
switch_command     "SWITCH" + "("  [expression_var] + ")"
case_command       "CASE"   + "("  [expression_var] + ")" + ":"
default_command    "DEFAULT" + ":" 
print_command      "PRINT" + "(" """ + [text] + """ + ("[" + var_name + "]")* + ")"
break_command      "BREAK;"
   

%%


{"PROGRAM"}         {return(PROGRAM)}
{name}              {return(STRING)}
{new_line}          {return(NEW_LINE)}
{"FUNCTION"}        {return(FUNCTION)}             
{declaration_f_par} {sscanf(yytext, "%s", yylval.f_par); return(F_PARAMETERS)}
{declaration_f_var} {sscanf(yytext, "%s", yylval.f_var); return(F_DECLARATIONS)} 
{"RETURN"}          {return(RETURN)}
{var}               {sscanf(yytext, "%s", yylval.var); return(VARS)}
{"END_FUNCTION"}    {return(END_FUNCTION)}
{"STARTMAIN"}       {return(STARTMAIN)}
{assignment}	    {sscanf(yytext, "%s", yylval.assignment); return(ASSIGNMENT)}
{while_command}	    {return(WHILE_COMMAND)}
{"END_WHILE"}       {return(END_WHILE)}
{for_command}	    {return(FOR_COMMAND)}
{"END_FOR"}         {return(END_FOR)}
{if_command}        {return(IF_COMMAND)}
{elseif_command}    {return(ELSEIF_COMMAND)}
{"ELSE"}	    {return(ELSE)}
{"ENDIF"}           {return(ENDIF)}
{switch_command}    {return(SWITCH_COMMAND)}
{case_command}      {return(CASE_COMMAND)}
{"DEFAULT"}         {return(DEFAULT)}
{"ENDSWITCH"}       {return(ENDSWITCH)}
{print_command}     {return(PRINT_COMMAND)}
{break_command}	  {return(BREAK_COMMAND)}
{"ENDMAIN"}         {return(ENDMAIN)}
.                   {show_Error();return(OTHER)}

%%

void showError(){
    printf("Other input");
}
