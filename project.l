%{
#include <stdio.h>
#include <string.h>
#include "project.tab.h"
void showError();
int linenum = 1;
char* get_string_no_space(char *str,int len);
%}


numbers (([0-9]+)(";")*)
text  (" ")*[a-z][a-z0-9]*(("("([a-z][a-z0-9]*("["(([0-9]+)|([a-z]*))"]")*",")*")")|((","*[a-z][a-z0-9]*)*("["(([0-9]+)|([a-z]*))"]")*)|(","))*(";")*
struct_text "''"(([a-z][a-z0-9]*)|([0-9]+))"''"";"
new_line [\n]
tab      [\t]
space     " "
semicolon ";"
vars      "VARS"(" ")*("CHAR"|"INTEGER")(" ")*[a-z][a-z0-9]*("["[0-9]+"]")* 
declaration_f_par  (" ")*"("("VARS"(" ")*("CHAR"|"INTEGER")(" ")*[a-z][a-z0-9]*("[""]")*(",")*)*")" 
declaration_f_var  ("VARS"(" ")*("CHAR"|"INTEGER")(" ")*[a-z][a-z0-9]*("["[0-9]+"]")*(","(" ")*[a-z][a-z0-9]*("["[0-9]+"]")*)*";")*
return_var        "RETURN"(" ")*(([a-z][a-z0-9]*)|([0-9]+))*";"
function           [a-z][a-z0-9]*"("([a-z][a-z0-9]*(",")*)*")"";"
expression_var    (([a-z][a-z0-9]*)|([0-9]+))(("+"|"-"|"\"|"*"|"^")(([a-z][a-z0-9]*)|([0-9]+)|([a-z][a-z0-9]*"("([a-z][a-z0-9]*("[""]")*)|([0-9]+)(",")*)*")")))* 
assignment        [a-z][a-z0-9]*(" ")*"="(" ")*(([a-z][a-z0-9]*)|("\""([a-z0-9A-Z" "])*"\"")|([0-9]+([a-z])*)|([a-z][a-z0-9]*"("([a-z][a-z0-9]*("["[0-9]+"]")*(",")*)*")"))(" ")*(("+"|"-"|"/"|"*"|"^")(" ")*(([a-z][a-z0-9]*)|([0-9]+([a-z])*)|([a-z][a-z0-9]*"("([a-z][a-z0-9]*("[]")*(",")*)*")")))*";"
condition         "("(([a-z][a-z0-9]*)|[0-9]+)("<"|">"|"!="|"=="|"AND"|"OR")([a-z][a-z0-9]*)|([0-9]+)|("''"[a-z][a-z0-9]*"''"))")"
for_command        "FOR"(" ")*([a-z][a-z0-9]*)(" ")*(":="(([0-9]+)|([a-z][a-z0-9]*)))*(" ")*"TO"(" ")*(([0-9]+)|([a-z][a-z0-9]*))(" ")*"STEP"(" ")*(([0-9]+)|([a-z][a-z0-9]*))
while_command      "WHILE""("(([a-z][a-z0-9]*)|([0-9]+))("<"|">"|"!="|"=="|"AND"|"OR")(([a-z][a-z0-9]*)|([0-9]+))")"
if_command         "IF"(" ")*"("(([a-z][a-z0-9]*)|([0-9]+))(("<"|">"|"!="|"=="|"AND"|"OR")(([a-z][a-z0-9]*)|([0-9]+)))*")"(" ")*"THEN"
elseif_command     "ELSEIF"(" ")*"("(([a-z][a-z0-9]*)|([0-9]+))(("<"|">"|"!="|"=="|"AND"|"OR")(([a-z][a-z0-9]*)|([0-9]+)))*")"(" ")*"THEN"
switch_command     "SWITCH""("(([a-z][a-z0-9]*)|([0-9]+)|("''"[a-z][a-z0-9]*"''"))(("+"|"-"|"/"|"*"|"^")(([a-z][a-z0-9]*)|([0-9]+)|([a-z][a-z0-9]*"("(([a-z][a-z0-9]*("[""]")*)|([0-9]+)(",")*)*")")))*")"
case_command       "CASE""("(([a-z][a-z0-9]*)|([0-9]+)|("''"[a-z][a-z0-9]*"''"))(("+"|"-"|"/"|"*"|"^")(([a-z][a-z0-9]*)|([0-9]+)|([a-z][a-z0-9]*"("(([a-z][a-z0-9]*("[""]")*)|([0-9]+)(",")*)*")")))*")"":"
default_command    "DEFAULT"":" 
print_command      "PRINT""(""''"(" ")*[a-z][a-z0-9]*(("("([a-z][a-z0-9]*("["(([0-9]+)|([a-z][a-z0-9]*))"]")*(",")*)*")")|(","[a-z][a-z0-9]*("["(([0-9]+)|([a-z][a-z0-9]*))"]")*)|((" ")*[a-z][a-z0-9]*)|("["(([0-9]+)|([a-z][a-z0-9]*))"]")*)*(";")*"''"("["[a-z][a-z0-9]*((","[a-z][a-z0-9]*)|("["(([0-9]+)|([a-z][a-z0-9]*))"]"))*"]")*")"";"
break_command      "BREAK;"
struct             "STRUCT"(" ")*[a-z][a-z0-9]*
type_struct 	   "TYPEDEF"" ""STRUCT"
end_t_struct       [a-z][a-z0-9]*(" ")*"ENDSTRUCT"
   

%%

"PROGRAM"           {return(PROGRAM);}
{text}              {sscanf(yytext, "%s", yylval.variables);return(STRING);}
{struct_text}	    {sscanf(yytext,"%s",yylval.variables);return(STRING2);}
{numbers}	    {sscanf(yytext,"%s",yylval.nums);return(NUMBERS);}
{new_line}          {linenum++; return(NEW_LINE);}
{tab}		    {return(TAB);}
{semicolon}	    {return(SEMICOLON);}
{space}	            {return(SPACE);}
"VARS_CHAR "         {return(VARS_CHAR);}		  
"VARS_INTEGER"	    {return(VARS_INTEGER);}
"FUNCTION"          {return(FUNCTION);}             
{declaration_f_par} {sscanf(yytext, "%s", yylval.variables); return(F_PARAMETERS);}
{declaration_f_var} {sscanf(get_string_no_space(yytext,yyleng), "%s", yylval.prog_name); return(F_DECLARATIONS);}  
{return_var}	    {return(RETURN_VAR);}
"END_FUNCTION"      {return(END_FUNCTION);}
"STARTMAIN"         {return(STARTMAIN);}
{assignment}        {sscanf(yytext, "%s", yylval.assignment); return(ASSIGNMENT);}
{while_command}	    {return(WHILE_COMMAND);}
"END_WHILE"         {return(END_WHILE);}
{for_command}	    {return(FOR_COMMAND);}
"END_FOR"           {return(END_FOR);}
{if_command}        {return(IF_COMMAND);}
{elseif_command}    {return(ELSE_IF);}
"ELSE"	            {return(ELSE);}
"ENDIF"             {return(END_IF);}
{switch_command}    {return(SWITCH_COMMAND);}
{case_command}      {return(CASE_COMMAND);}
"DEFAULT:"           {return(DEFAULT);}
"ENDSWITCH"         {return(ENDSWITCH);}
{print_command}     {return(PRINT_COMMAND);}
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
"RETURN"	    {return(RETURN);}
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
