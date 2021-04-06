%{
#include <stdio.h>
#include<stdlib.h>
#include<string.h>

int yylex();
int yyerror(char *s);
extern int linenum;
static int count_varschar=0;
static int count_varsint=0;
void check_var_names(char* str1,char* str2);
char* c_vars;
char* i_vars;
%}

%token PROGRAM STRING NEW_LINE FUNCTION F_PARAMETERS F_DECLARATIONS
%token END_FUNCTION STARTMAIN ASSIGNMENT WHILE_COMMAND
%token END_WHILE FOR_COMMAND END_FOR IF_COMMAND ELSEIF_COMMAND ELSE
%token ENDIF SWITCH_COMMAND CASE_COMMAND DEFAULT ENDSWITCH
%token PRINT_COMMAND BREAK_COMMAND ENDMAIN OTHER RETURN_VAR
%token TAB SPACE VARS_CHAR VARS_INTEGER SEMICOLON STRING2
%token STRUCT ENDSTRUCT TYPE_STRUCT END_T_STRUCT
%token PLUS MINUS MUL DIV POWER EQUAL	

%type <prog_name>    STRING
%type <variables>    STRING2
%type <variables>    F_PARAMETERS
%type <prog_name>    F_DECLARATIONS
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
	
	|for NEW_LINE   
                {
			printf("\nI LOVE FOR");
		}

	|while NEW_LINE
		{
			printf("\nI LOVE WHILE ALSO");
		}
	|switch
	

	|print 
		{	
			printf("\nPrint is ok also");
		}

	|struct {
			printf("\nStruct works perfectly");
		}			
		
	|STRING

		{
			printf("\nJust testing strings");
		}

	|assignments

		{
			printf("\nWorking on assignments");

		}
	
	| OTHER	
		{
			printf("\nGTPK input");
		}

	|declarations_char  NEW_LINE declarations_int 
		{
			check_var_names(c_vars,i_vars);
		}
		

;		

		

	



function:


	 FUNCTION STRING F_PARAMETERS NEW_LINE VARS_CHAR  STRING
		{
			printf("\nI love you\n");
		} 
	
	| FUNCTION STRING F_PARAMETERS NEW_LINE ASSIGNMENT NEW_LINE RETURN_VAR NEW_LINE END_FUNCTION NEW_LINE
		
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
	  FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_FOR
	
	| FOR_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB  ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB END_FOR
	
	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_FOR 
	
	| FOR_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB END_FOR 
	
	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE END_FOR
	
	| FOR_COMMAND NEW_LINE TAB  ASSIGNMENT NEW_LINE TAB END_FOR
	
	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE TAB FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB  END_FOR NEW_LINE END_FOR   
	
	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE TAB FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB END_FOR NEW_LINE END_FOR

	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE  ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE TAB FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB END_FOR NEW_LINE END_FOR
	
	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE TAB FOR_COMMAND NEW_LINE TAB END_FOR NEW_LINE END_FOR
	
	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE  ASSIGNMENT NEW_LINE TAB FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB END_FOR NEW_LINE END_FOR 
	
	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE  ASSIGNMENT NEW_LINE TAB FOR_COMMAND NEW_LINE TAB TAB  ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB END_FOR NEW_LINE END_FOR 
	
	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE  ASSIGNMENT NEW_LINE TAB FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB END_FOR NEW_LINE END_FOR
	
	|FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE  ASSIGNMENT NEW_LINE TAB FOR_COMMAND NEW_LINE TAB END_FOR NEW_LINE END_FOR

	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE TAB FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB END_FOR NEW_LINE END_FOR
	
	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE TAB FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB END_FOR NEW_LINE END_FOR 

	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE TAB FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB END_FOR NEW_LINE END_FOR
	
	| FOR_COMMAND NEW_LINE ASSIGNMENT NEW_LINE TAB FOR_COMMAND NEW_LINE TAB END_FOR NEW_LINE END_FOR

	| FOR_COMMAND NEW_LINE TAB FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB END_FOR NEW_LINE END_FOR  

	| FOR_COMMAND NEW_LINE TAB FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB END_FOR NEW_LINE END_FOR

	| FOR_COMMAND NEW_LINE TAB FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB END_FOR NEW_LINE END_FOR

	| FOR_COMMAND NEW_LINE TAB FOR_COMMAND NEW_LINE TAB END_FOR NEW_LINE END_FOR	
	
	| FOR_COMMAND NEW_LINE TAB NEW_LINE for NEW_LINE NEW_LINE TAB END_FOR

	| FOR_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB NEW_LINE TAB for NEW_LINE NEW_LINE  TAB END_FOR

	| FOR_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB NEW_LINE TAB  for NEW_LINE NEW_LINE TAB END_FOR

	| FOR_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB NEW_LINE TAB  for NEW_LINE NEW_LINE TAB END_FOR

	| FOR_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE NEW_LINE TAB while NEW_LINE NEW_LINE TAB END_FOR

	| FOR_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE NEW_LINE TAB while NEW_LINE NEW_LINE TAB END_FOR

	| FOR_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE NEW_LINE TAB while NEW_LINE NEW_LINE TAB END_FOR 

	| FOR_COMMAND NEW_LINE TAB print NEW_LINE END_FOR

	| FOR_COMMAND NEW_LINE TAB ASSIGNMENT print NEW_LINE END_FOR
	
	| FOR_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT print NEW_LINE END_FOR
	
	| FOR_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT print NEW_LINE END_FOR
	
	| FOR_COMMAND NEW_LINE TAB  for NEW_LINE print NEW_LINE  END_FOR
	
	| FOR_COMMAND NEW_LINE TAB while NEW_LINE print NEW_LINE END_FOR
	
	| FOR_COMMAND NEW_LINE TAB for NEW_LINE END_FOR

	| FOR_COMMAND NEW_LINE TAB while NEW_LINE END_FOR
	
	| FOR_COMMAND NEW_LINE TAB TAB print NEW_LINE TAB END_FOR

	| FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB print NEW_LINE  TAB END_FOR
	
	| FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB print NEW_LINE  TAB END_FOR

	| FOR_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB print NEW_LINE TAB END_FOR 
	
	
;	


while:
	

         WHILE_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_WHILE
	{
		printf("WHILE IS MY WIFE\n");
	}
	
	| WHILE_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT  NEW_LINE  END_WHILE
	
	{
		printf("\nFOR THE SAKE OF HUMANITY WORK PLS");
	}

	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB  END_WHILE

	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB END_WHILE
	
	|WHILE_COMMAND NEW_LINE ASSIGNMENT NEW_LINE  END_WHILE

	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB END_WHILE

	|WHILE_COMMAND NEW_LINE TAB for NEW_LINE END_WHILE
	
	|WHILE_COMMAND NEW_LINE TAB for NEW_LINE TAB END_WHILE

	|WHILE_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE  TAB for NEW_LINE END_WHILE
	
	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB for NEW_LINE TAB END_WHILE
	
	|WHILE_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE  TAB for NEW_LINE END_WHILE
	
	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB for NEW_LINE TAB END_WHILE 

	|WHILE_COMMAND NEW_LINE TAB  while NEW_LINE END_WHILE

	|WHILE_COMMAND NEW_LINE TAB switch NEW_LINE END_WHILE
	 
	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE NEW_LINE TAB for NEW_LINE NEW_LINE TAB  END_WHILE
	
	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE NEW_LINE TAB for NEW_LINE NEW_LINE TAB  END_WHILE 
	
	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE NEW_LINE TAB for NEW_LINE NEW_LINE TAB END_WHILE
	
	|WHILE_COMMAND NEW_LINE TAB while NEW_LINE NEW_LINE TAB  END_WHILE

	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE NEW_LINE TAB while NEW_LINE NEW_LINE TAB  END_WHILE
	
	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE NEW_LINE TAB while NEW_LINE NEW_LINE TAB  END_WHILE
	
	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE NEW_LINE TAB while NEW_LINE NEW_LINE TAB END_WHILE 

	|WHILE_COMMAND NEW_LINE TAB print NEW_LINE END_WHILE

	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB print NEW_LINE END_WHILE
	
	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB print NEW_LINE END_WHILE

	|WHILE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB print NEW_LINE END_WHILE

	|WHILE_COMMAND NEW_LINE TAB for NEW_LINE print NEW_LINE END_WHILE
	
	|WHILE_COMMAND NEW_LINE TAB while NEW_LINE print NEW_LINE END_WHILE

	|WHILE_COMMAND NEW_LINE TAB TAB print NEW_LINE TAB TAB END_WHILE
	
	|WHILE_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB print NEW_LINE TAB TAB END_WHILE

	|WHILE_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB print NEW_LINE TAB TAB END_WHILE

	|WHILE_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB print NEW_LINE TAB TAB END_WHILE 

	|WHILE_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB END_WHILE
	
	|WHILE_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB END_WHILE
	
	|WHILE_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB ASSIGNMENT NEW_LINE TAB TAB END_WHILE 
	
	|WHILE_COMMAND NEW_LINE ASSIGNMENT NEW_LINE TAB for NEW_LINE END_WHILE

	|WHILE_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE TAB for NEW_LINE END_WHILE

	|WHILE_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE TAB for NEW_LINE END_WHILE

	
;	

switch:
       
      SWITCH_COMMAND NEW_LINE  case NEW_LINE ENDSWITCH NEW_LINE
	{
	   printf("\nSwitch-Case-Default i love you guys");
	} 

      |SWITCH_COMMAND NEW_LINE case NEW_LINE  
	{
	   printf("\nSwitch works fine!!");
	}	
	

;

case:
	
	CASE_COMMAND NEW_LINE TAB ASSIGNMENT 
	
	|CASE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT
	
        |CASE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT 

	|CASE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE
	
	|CASE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE

	|CASE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE 
	
	|CASE_COMMAND NEW_LINE TAB for NEW_LINE case 
	
	|CASE_COMMAND NEW_LINE TAB while NEW_LINE case 
		
	|CASE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB for NEW_LINE case 

        |CASE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB while NEW_LINE case 

	|CASE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB  for NEW_LINE case
	
	|CASE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB  while NEW_LINE case

	|CASE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB  for NEW_LINE case

	|CASE_COMMAND NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB  while NEW_LINE case
 
	|CASE_COMMAND NEW_LINE  case NEW_LINE case NEW_LINE default

	|CASE_COMMAND NEW_LINE  case NEW_LINE  default

	|CASE_COMMAND NEW_LINE  case  NEW_LINE case

	|CASE_COMMAND NEW_LINE  case 

	|ENDSWITCH

	|default
;

default:

	DEFAULT NEW_LINE TAB for NEW_LINE
	
	|DEFAULT NEW_LINE TAB while NEW_LINE

	|DEFAULT NEW_LINE TAB ASSIGNMENT NEW_LINE   

	|DEFAULT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB  for NEW_LINE  

	|DEFAULT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB while NEW_LINE

	|DEFAULT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE 
	
	|DEFAULT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB  for NEW_LINE

	|DEFAULT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB while NEW_LINE

	|DEFAULT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE
	
	|DEFAULT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB for NEW_LINE

	|DEFAULT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB ASSIGNMENT NEW_LINE TAB while NEW_LINE
	
;


 if:
      | IF_COMMAND NEW_LINE TAB TAB ASSIGNMENT NEW_LINE  TAB ELSE_IF NEW_LINE TAB TAB  ASSIGNMENT NEW_LINE TAB ELSE_IF NEW_LINE TAB TAB  ASSIGNMENT NEW_LINE TAB ELSE_IF NEW_LINE TAB TAB  ASSIGNMENT NEW_LINE TAB END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE  END_IF
      
      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE NEW_LINE END_IF    

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF for NEW_LINE NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF while NEW_LINE NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF switch NEW_LINE NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE for NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE while NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE switch NEW_LINE END_IF 

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE for NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE switch NEW_LINE END_IF 

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE while NEW_LINE END_IF 

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE for NEW_LINE  ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF 

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE while NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE switch NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE NEW_LINE while NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE NEW_LINE switch NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE NEW_LINE for NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE for NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE for ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE for ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE_IF NEW_LINE for ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE_IF NEW_LINE for ELSE_IF NEW_LINE for ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE_IF NEW_LINE for ELSE_IF NEW_LINE for ELSE_IF NEW_LINE for NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE whie NEW_LINE ELSE_IF NEW_LINE while ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE_IF NEW_LINE while ELSE_IF NEW_LINE while ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE_IF NEW_LINE while ELSE_IF NEW_LINE while ELSE_IF NEW_LINE while NEW_LINE END_IF

      | IF_COMMAND NEW_LINE switch NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE switch NEW_LINE ELSE_IF NEW_LINE switch ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE switch NEW_LINE ELSE_IF NEW_LINE switch ELSE_IF NEW_LINE switch ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE switch NEW_LINE ELSE_IF NEW_LINE switch ELSE_IF NEW_LINE switch ELSE_IF NEW_LINE switch NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE_IF NEW_LINE while ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE_IF NEW_LINE for ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE_IF NEW_LINE for ELSE_IF NEW_LINE for ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE_IF NEW_LINE while ELSE_IF NEW_LINE while ELSE_IF NEW_LINE switch NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE_IF NEW_LINE for ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE_IF NEW_LINE for ELSE_IF NEW_LINE for NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE for ELSE_IF NEW_LINE for NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE_IF NEW_LINE while ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE_IF NEW_LINE while ELSE_IF NEW_LINE while NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE while ELSE_IF NEW_LINE while NEW_LINE END_IF

      | IF_COMMAND NEW_LINE switch NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE switch NEW_LINE ELSE_IF NEW_LINE switch ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE switch NEW_LINE ELSE_IF NEW_LINE switch ELSE_IF NEW_LINE switch NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE switch ELSE_IF NEW_LINE switch NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE_IF  NEW_LINE ASSIGNMENT ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE_IF NEW_LINE for ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE_IF NEW_LINE for ELSE NEW_LINE for NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE for ELSE NEW_LINE for NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE_IF NEW_LINE while ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE_IF NEW_LINE while ELSE NEW_LINE while NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE while ELSE NEW_LINE while NEW_LINE END_IF

      | IF_COMMAND NEW_LINE switch NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE switch NEW_LINE ELSE_IF NEW_LINE switch ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE switch NEW_LINE ELSE_IF NEW_LINE switch ELSE NEW_LINE switch NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE switch ELSE NEW_LINE switch NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE_IF NEW_LINE print ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE_IF NEW_LINE print ELSE NEW_LINE print NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE print ELSE NEW_LINE print NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE_IF NEW_LINE print ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE_IF NEW_LINE print ELSE_IF NEW_LINE print ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE_IF NEW_LINE print ELSE_IF NEW_LINE print ELSE_IF NEW_LINE print NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT ELSE_IF NEW_LINE ASSIGNMENT ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE_IF NEW_LINE print ELSE_IF NEW_LINE ASSIGNMENT ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE_IF NEW_LINE print ELSE_IF NEW_LINE print ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE_IF NEW_LINE print ELSE_IF NEW_LINE print ELSE NEW_LINE print NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF print NEW_LINE NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE_IF ASSIGNMENT NEW_LINE NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE print NEW_LINE NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE ASSIGNMENT NEW_LINE NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE  ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF      

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMEN NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMEN NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMEN NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF      

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE_IF NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMEN NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMEN NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMEN NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE for NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMEN NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE for NEW_LINE NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE while NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMEN NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE while NEW_LINE NEW_LINE END_IF

      | IF_COMMAND NEW_LINE switch NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE switch NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMEN NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE switch NEW_LINE NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE END_IF

      | IF_COMMAND NEW_LINE print NEW_LINE ELSE NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMEN NEW_LINE END_IF

      | IF_COMMAND NEW_LINE ASSIGNMENT NEW_LINE ASSIGNMENT NEW_LINE ELSE NEW_LINE print NEW_LINE NEW_LINE END_IF


;
	

print:

	PRINT_COMMAND 
	

;


declarations_char:

	 VARS_CHAR STRING
	{
	    count_varschar++;

	    if(count_varschar==1)
	    {
	      c_vars = (char*)malloc(count_varschar*sizeof(char));
	      strcpy(c_vars,$2);
	    }

	   else
	   {
	     c_vars = (char*)realloc(c_vars,count_varschar*sizeof(char));
	     strcat(c_vars,$2);
		
	   }
	
	}  

;


declarations_int:

	VARS_INTEGER STRING
	{
	  count_varsint++;

            if(count_varsint==1)
            {
              i_vars = (char*)malloc(count_varsint*sizeof(char));
              strcpy(i_vars,$2);
            }

           else
           {
             i_vars = (char*)realloc(i_vars,count_varsint*sizeof(char));
             strcat(i_vars,$2);

           }

        } 


	 
;

assignments:
		
	STRING EQUAL STRING NEW_LINE
	{
		
	}

	|STRING EQUAL STRING PLUS STRING

	|STRING EQUAL STRING MINUS STRING

	|STRING EQUAL STRING MUL STRING

	|STRING EQUAL STRING DIV STRING

	|STRING EQUAL STRING POWER STRING
	
;
	

struct:
	STRUCT  NEW_LINE declarations_char NEW_LINE declarations_int NEW_LINE ENDSTRUCT
	
	|TYPE_STRUCT STRING NEW_LINE declarations_char NEW_LINE declarations_int NEW_LINE END_T_STRUCT NEW_LINE

;



%%

int yyerror(char *s)
{
	printf("Syntax Error on line %d\n", linenum);
	return 0;
}

void  check_var_names(char* str1,char* str2)
{
    char c_vars1[100];
    char i_vars1[100];
    int k=0;
    int i=0;
    int flag=0;
    int len1 = strlen(str1);
    int len2 = strlen(str2); 
    char* coma1 = NULL;
    char* coma2 = NULL;    
		
   printf("%s\t%s",str1,str2);
   printf("%d\t%d",len1,len2);

      coma1 = strchr(str1, ',');
      coma2 = strchr(str2, ',');

	if(coma1==NULL && coma2==NULL)
		{
			flag = strcmp(str1,str2);
			if(flag==0)
				{
				    printf("\nSame name different type");	
				    exit(0);
				}
			else
			   {
				return;
			   }
		}

	else if(coma1==NULL && coma2!=NULL)
	{
	
	  while(1)
           {

             if(str2[k]!=',')
                {
                   i_vars[k] = str2[k];
                   k++;
                }


             if(str2[k]==',' || str2[k]==';')
                {
                    flag = strcmp(str1,i_vars1);
                    if(flag==0)
                        {
                            printf("\nDifferent types same name");
                            exit(-1);
                        }
                }

	    if(str2[k]==len2)
		break;
          }
			
	}

	else if(coma1!=NULL && coma2==NULL)
	{
	    while(1)
            {
              if(str1[i]!=',' && i<len1)
                {
                        c_vars1[i] = str1[i];
                        i++;
                }

             if(str1[i]==',')
                {
                    flag = strcmp(c_vars1,str2);
                    if(flag==0)
                        {
                            printf("\nDifferent types same name");
                            exit(-1);
                        }
                }

	    if(i==len1-1)
		break;

	    }		
	}

	else
	{
		
         while(1)
	 {     
	     if(str1[i]!=',' && i<len1)
		{
			c_vars1[i] = str1[i];
			i++;
		}	

	     if(str2[k]!=',' && k<len2)
                {
                   i_vars[k] = str2[k];
                   k++;
                }


	     if(str1[i]==',' && str2[k]==',')
		{		
	            flag = strcmp(c_vars1,i_vars1);
	            if(flag==0)
			{
		            printf("\nDifferent types same name");
			    exit(-1);
			}
		}

	    

            if( (i==len1-1) && (k==len2-1) )
	          break;
	     
	 } 

	} 
}	



	

int main()
{

system("clear");
yyparse();

return 0;

}


