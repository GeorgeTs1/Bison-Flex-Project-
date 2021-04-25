%{
#include <stdio.h>
#include <string.h>
#include "project.tab.h"
void showError();
int linenum = 1;
char* get_string_no_space(char *str,int len);
%}

%x ML_COMMENT 
numbers (([0-9]+)(";"))
text  (" ")*[a-z][a-z0-9]*(("("([a-z][a-z0-9]*("["(([0-9]+)|([a-z]*))"]")*",")*")")|((","*[a-z][a-z0-9]*)*("["(([0-9]+)|([a-z]*))"]")*)|(","))*(";")*
struct_assignment [a-z][a-z0-9]*"."[a-z][a-z0-9]*"="(([a-z][a-z0-9]*)|("\""([a-z0-9A-Z" "])*"\"")|([0-9]+([a-z])*)|([a-z][a-z0-9]*"("([a-z][a-z0-9]*("["[0-9]+"]")*(",")*)*(" ")*")"))(" ")*(("+"|"-"|"/"|"*"|"^")(" ")*(([a-z][a-z0-9]*)|([0-9]+([a-z])*)|([a-z][a-z0-9]*"("([a-z][a-z0-9]*("[]")*(",")*)*")")))*";"
new_line [\n]
tab      [\t]
space     " "
return_var         "RETURN"("_")?(([a-z][a-z0-9]*)|("\""[a-z][a-z0-9]*"\"")|([0-9]+))";"
function           [a-z][a-z0-9]*"("([a-z][a-z0-9]*(",")*)*")"";"
expression_var    (([a-z][a-z0-9]*)|([0-9]+))(("+"|"-"|"\"|"*"|"^")(([a-z][a-z0-9]*)|([0-9]+)|([a-z][a-z0-9]*"("([a-z][a-z0-9]*("[""]")*)|([0-9]+)(",")*)*")")))* 
assignment         [a-z][a-z0-9]*("["(([a-z][a-z0-9]*)|([0-9]+))"]")*(" ")*"="(" ")*(([a-z][a-z0-9]*)|("\""([a-z0-9A-Z" "])*"\"")|([0-9]+([a-z])*)|([a-z][a-z0-9]*"("([a-z][a-z0-9]*("["[0-9]+"]")*(",")*)*(" ")*")"))(" ")*(("+"|"-"|"/"|"*"|"^")(" ")*(([a-z][a-z0-9]*)|([0-9]+([a-z])*)|([a-z][a-z0-9]*"("([a-z][a-z0-9]*("[]")*(",")*)*")")))*";"
condition         "("(([a-z][a-z0-9]*)|[0-9]+)("<"|">"|"!="|"=="|"AND"|"OR")([a-z][a-z0-9]*)|([0-9]+)|("''"[a-z][a-z0-9]*"''"))")"
for_command        "FOR"(" ")*([a-z][a-z0-9]*)(" ")*(":="(([0-9]+)|([a-z][a-z0-9]*)))*(" ")*"TO"(" ")*(([0-9]+)|([a-z][a-z0-9]*))(" ")*"STEP"(" ")*(([0-9]+)|([a-z][a-z0-9]*))
while_command      "WHILE""("(([a-z][a-z0-9]*)|([0-9]+))("<"|">"|"!="|"=="|"AND"|"OR")(([a-z][a-z0-9]*)|([0-9]+))")"
if_command         "IF"(" ")*"("(([a-z][a-z0-9]*)|([0-9]+))(("<"|">"|"!="|"=="|"AND"|"OR")(([a-z][a-z0-9]*)|([0-9]+)))*")"(" ")*"THEN"
elseif_command     "ELSEIF"(" ")*"("(([a-z][a-z0-9]*)|([0-9]+))(("<"|">"|"!="|"=="|"AND"|"OR")(([a-z][a-z0-9]*)|([0-9]+)))*")"(" ")*"THEN"
switch_command     "SWITCH""("(([a-z][a-z0-9]*)|([0-9]+)|("''"[a-z][a-z0-9]*"''"))(("+"|"-"|"/"|"*"|"^")(([a-z][a-z0-9]*)|([0-9]+)|([a-z][a-z0-9]*"("(([a-z][a-z0-9]*("[""]")*)|([0-9]+)(",")*)*")")))*")"
case_command       "CASE""("(([a-z][a-z0-9]*)|([0-9]+)|("\""[a-z][a-z0-9]*"\""))(("+"|"-"|"/"|"*"|"^")(([a-z][a-z0-9]*)|([0-9]+)|([a-z][a-z0-9]*"("(([a-z][a-z0-9]*("[""]")*)|([0-9]+)(",")*)*")")))*")"":"
default_command    "DEFAULT"":" 
print_command      "PRINT""(""\""(" ")*[a-z][a-z0-9]*(("("([a-z][a-z0-9]*("["(([0-9]+)|([a-z][a-z0-9]*))"]")*(",")*)*")")|(","[a-z][a-z0-9]*("["(([0-9]+)|([a-z][a-z0-9]*))"]")*)|((" ")*[a-z][a-z0-9]*)|("["(([0-9]+)|([a-z][a-z0-9]*))"]")*)*(";")*"\""("["[a-z][a-z0-9]*((","[a-z][a-z0-9]*)|("["(([0-9]+)|([a-z][a-z0-9]*))"]"))*"]")*")"";"
break_command      "BREAK;"
struct             "STRUCT"" "
type_struct 	   "TYPEDEF"" ""STRUCT"
end_t_struct       [a-z][a-z0-9]*(" ")*"ENDSTRUCT"
 

%%
<INITIAL>"/*"                   BEGIN(ML_COMMENT);
<ML_COMMENT>"*/"                BEGIN(INITIAL);
<ML_COMMENT>.|"\n"              { }	
"PROGRAM"           {return(PROGRAM);}
{text}              {sscanf(yytext, "%s", yylval.variables);return(STRING);}
{numbers}           {sscanf(yytext,"%s",yylval.variables);return(NUMBERS);}
{struct_assignment} {sscanf(yytext,"%s",yylval.variables);return(STRUCT_ASSIGNMENT);}
{new_line}          {linenum++; return(NEW_LINE);}
{tab}		    {return(TAB);}
{space}	            {return(SPACE);}
"VARS_CHAR "         {return(VARS_CHAR);}		  
"VARS_INTEGER"	    {return(VARS_INTEGER);}
"FUNCTION"          {return(FUNCTION);}               
{return_var}	    {sscanf(yytext, "%s", yylval.commands);return(RETURN_VAR);}
"END_FUNCTION"      {return(END_FUNCTION);}
"STARTMAIN"         {return(STARTMAIN);}
{assignment}        {sscanf(yytext, "%s", yylval.assignment);return(ASSIGNMENT);}
{while_command}	    {sscanf(yytext, "%s", yylval.commands);return(WHILE_COMMAND);}
"END_WHILE"         {return(END_WHILE);}
{for_command}	    {return(FOR_COMMAND);}
"END_FOR"           {return(END_FOR);}
{if_command}        {sscanf(yytext, "%s", yylval.commands);return(IF_COMMAND);}
{elseif_command}    {sscanf(yytext, "%s", yylval.commands);return(ELSE_IF);}
"ELSE"	            {return(ELSE);}
"ENDIF"             {return(END_IF);}
{switch_command}    {sscanf(yytext, "%s", yylval.commands);return(SWITCH_COMMAND);}
{case_command}      {return(CASE_COMMAND);}
"DEFAULT:"          {return(DEFAULT);}
"ENDSWITCH"         {return(ENDSWITCH);}
{print_command}     {sscanf(yytext, "%s", yylval.commands);return(PRINT_COMMAND);}
{break_command}	    {return(BREAK_COMMAND);}
"ENDMAIN"           {return(ENDMAIN);}
{struct}	    {return(STRUCT);}
{type_struct} 	    {return(TYPE_STRUCT);}
"ENDSTRUCT"         {return(ENDSTRUCT);}
{end_t_struct}	    {return(END_T_STRUCT);}
"="		    {return(EQUAL);}
"+"		    {return(PLUS);}
"-"		    {return(MINUS);}
"*"		    {return(MUL);}
"/"		    {return(DIV);}
"^"		    {return(POWER);}
"("		    {return(L_PAR);}
")"		    {return(R_PAR);}
"."                 {return(DOT);}
.                   {showError();return(OTHER);}



%%

void showError(){
    printf("Other input");
}
char* get_string_no_space(char* str,int len)
{
   char* str1;
   int k=0;

   for(int i=0; i<len+2; i++)
	{
	   if(str[i]==' ')
		continue;
		 

	  else
	  {
	    str1[k]=str[i];
	    k++;
	  }
	
	}


return str1;

}
