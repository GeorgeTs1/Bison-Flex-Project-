%{
#include <stdio.h>

int yylex();
int yyerror(char *s);

char get_prog_name(char prog[]);

char prog_name[200];
char func_name[200];

%}

%token PROGRAM STRING NEW_LINE FUNCTION F_PARAMETERS F_DECLARATIONS
%token RETURN VARS END_FUNCTION STARTMAIN ASSIGNMENT WHILE_COMMAND
%token END_WHILE FOR_COMMAND END_FOR IF_COMMAND ELSEIF_COMMAND ELSE
%token ENDIF SWITCH_COMMAND CASE_cOMMAND DEFAULT ENDSWITCH
%token PRINT_COMMAND BREAK_COMMAND ENDMAIN OTHER


%type <prog_name>    STRING
%type <variables>    F_PARAMETERS
%type <variables>    F_DECLARATIONS
%type <variables>    VARS
%type <variables>    ASSIGNMENT
%type <commands>     WHILE_COMMAND
%type <commands>     FOR_COMMAND
%type <commands>     IF_COMMAND
%type <commands>     ELSEIF_COMMAND
%type <commands>     SWITCH_COMMAND
%type <commands>     CASE_COMMAND 
%type <commands>     PRINT_COMMAND		


%union{
    
    char function_name[200];
    char prog_name[200];
    char variables[200];
    char assignment[150];
    int number;
    char commands[150];
	
}

%%



prog:
  main
;


main:



program:

     PROGRAM + NEW_LINE
		{
			strcpy(prog_name,$1);
		}
	

function:

     FUNCTION + f_parameters 



%%

int yyerror(char *s)
{
	printf("Syntax Error on line %s\n", s);
	return 0;
}

	


int main()
{
