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
new_line ["\n"]
var  ["VARS"] + ( [char] | [int] ) + [var_name] + [table]* 
char ["CHAR"]
int  ["INTEGER"]
table ["["] + [numbers] + ["]"]
declaration_f_par  "(" + ([var] + [","])+ ")"
declaration_f_var  [var] + (","+[var])* + ";"
expression_var    (([name]|[numbers]) + ( ("+" | "-" | "\" | "*"|"^") + ([name]|[numbers])*) 
assignment         [var_name] + "=" [expression_var] + ";"



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
{


%%
