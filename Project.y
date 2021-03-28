
%{
#include <stdio.h>
#include<stdlib.h>
#include<string.h>

int yylex();
int yyerror(char *s);
extern int linenum;

char char_assign[150];
char int_assign[150];
char prog_name[200];
char func_name[200];

%}

%token PROGRAM STRING NEW_LINE FUNCTION F_PARAMETERS F_DECLARATIONS
%token RETURN VARS END_FUNCTION STARTMAIN ASSIGNMENT WHILE_COMMAND
%token END_WHILE FOR_COMMAND END_FOR IF_COMMAND ELSEIF_COMMAND ELSE
%token ENDIF SWITCH_COMMAND CASE_COMMAND DEFAULT ENDSWITCH
%token PRINT_COMMAND BREAK_COMMAND ENDMAIN OTHER RETURN_VAR


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

    program
;


program:
	PROGRAM STRING NEW_LINE  function STARTMAIN NEW_LINE
		{
			printf("\nGj man!!");
		}
	| PROGRAM STRING NEW_LINE STARTMAIN NEW_LINE
		{
			printf("\nRight input also");
		} 
	
	| 	{
			printf("\nYou didin't type anything :("); 
		}	
	| function
		
		{
			printf("\nProgram should start with PROGRAM prog_name");
		}
	
	|for   
                {
			printf("\nI LOVE FOR");
		}
		
	| OTHER	
		{
			printf("\nGTPK input");
		}
;	

	



function:

      FUNCTION STRING F_PARAMETERS NEW_LINE F_DECLARATIONS NEW_LINE F_DECLARATIONS NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE  RETURN RETURN_VAR NEW_LINE END_FUNCTION NEW_LINE 
		{
					
		}
	
	| FUNCTION STRING F_PARAMETERS NEW_LINE ASSIGNMENT NEW_LINE RETURN RETURN_VAR NEW_LINE END_FUNCTION NEW_LINE
		
		{
			printf("RIGHT INPUT");
		}
		
	| 
		{	
			printf("\nGTPK input");		
		}
	|OTHER      
                {
			printf("\nGTPK input");
		}
;	


for:
	FOR_COMMAND NEW_LINE
	{
		printf("\nFOR IS OK SHE WILL LIVE");
	}
		
;

%%

int yyerror(char *s)
{
	printf("Syntax Error on line %d\n", linenum);
	return 0;
}
	

int main()
{

system("clear");
yyparse();

return 0;

}

