#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdbool.h>
#include <sys/wait.h>
#include <sys/types.h>

#define PATH_LENGTH 256
#define CMD_LENGTH 128

void shell_init(void);
void start_process(char **);
char **parse_arguments(char *);

bool background;


int main(int argc, char *argv[])
{

	printf("\n===================================");	
	printf("\n\t Welcome to MyLSH!");
	printf("\n===================================\n");
	
	shell_init();

	printf("\n===================================");	
	printf("\n\tSee you next time!");
	printf("\n===================================\n\n");
	
	return 0;
}

void shell_init(void)
{
	char current_path[PATH_LENGTH];
	char command[CMD_LENGTH];
	char **arguments;
	int eof_check;
	bool exit_flag = true;

	background = false;

	do
	{
		getcwd(current_path, sizeof(current_path));
		printf("\n(%s) >>> ", current_path);

		eof_check = scanf(" %[^\n]%*c", command);

		arguments = parse_arguments(command);
	
		if(strcmp(command, "exit") == 0 || eof_check == EOF)
		{
			exit_flag = false;	
		}
		else if(strcmp(command, "cd") == 0)
		{
			chdir(arguments[1]);
		}
		else
		{
			start_process(arguments);
		}
		

	}while(exit_flag);
}

char **parse_arguments(char *cmd)
{
	char *parsed; 
	char **bin_args;
	int i = 0;

	bin_args = malloc(16 * sizeof(char *));

	parsed = strtok(cmd, " \t\n");

	while(parsed != NULL)
	{
		bin_args[i] = parsed;

		parsed = strtok(NULL, " \t\n");
		i++;
	}

	if(strcmp(bin_args[i-1], "&") == 0)
	{
		bin_args[i-1] = NULL;
		background = true;
	}
	else
	{
		bin_args[i] = NULL;
	}

	return bin_args;
}

void start_process(char **args)
{
	int wait_status;
	
	pid_t pid = fork();
			
	if(pid == 0)
	{
		if((execvp(args[0], args)) == -1)
		{
			printf("\nNo such command found");
		}
		exit(0);
	}
	else if(pid < 0)
	{
		printf("\nAn error occured while creating new process\n");
	}
	else 
	{
		do 
		{
			if(background == false)
			{
				waitpid(pid, &wait_status, WUNTRACED);    
			}
			else
			{
				signal(SIGCHLD, SIG_IGN);
				background = false;
			}
		} while (!WIFEXITED(wait_status) && !WIFSIGNALED(wait_status));
	}
}
