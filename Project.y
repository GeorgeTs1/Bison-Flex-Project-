%{
#include <stdio.h>
#include<stdlib.h>
#include<string.h>

int yylex();
int yyerror(char *s);
void yyerror2(int type, char *s, char b[]);
extern int linenum;


char prog_name[200];
char func_name[200];
char space[1] = {" "};

%}

%token PROGRAM STRING NEW_LINE FUNCTION F_PARAMETERS F_DECLARATIONS
%token RETURN VARS END_FUNCTION STARTMAIN ASSIGNMENT WHILE_COMMAND
%token END_WHILE FOR_COMMAND END_FOR IF_COMMAND ELSEIF_COMMAND ELSE
%token ENDIF SWITCH_COMMAND CASE_COMMAND DEFAULT ENDSWITCH
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

    program 
;

program:

     PROGRAM STRING NEW_LINE
		{
			printf("RIGHT INPUT");
			strcpy(prog_name,$2);
		}
	| OTHER
		{

			yyerror2(1,"EXIT",space);		
		}
	|       
                {
			yyerror2(1,"Program should start with PROGRAM program_name",space);
		}
;	



%%

int yyerror(char *s)
{
	printf("Syntax Error on line %s\n", s);
	return 0;
}

void yyerror2(int type, char *s, char b[])
{

	switch(type){
		case 1:
			printf("Syntax Error on line - %d\n%s\n",linenum, s);
			break;
		case 2:
			printf("Lexical Error on line - %d: %s\n",linenum, s);
			break;
		case 3:
			printf("Line - %d: %s%s\n",linenum, s, b);
			break;
	}

	exit(0);
}	


int main()
{

system("clear");
yyparse();

return 0;

}

