#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

void signals_caller(pid_t);

int main(int argc, char *argv[])
{
	if(argc != 2)
	{
		printf("Please enter the PID as an argument\n");
		return 1;
	}

	pid_t pid;	
	long long int pid_temp = strtoll(argv[1], NULL, 0);
	pid = (pid_t) pid_temp;

	signals_caller(pid);

	return 0;
}

void signals_caller(pid_t pid)
{
	for(int i = 1; i <= 64; i++)
	{
		if(i == 9 || i == 15 || i == 17 || i == 19 || i == 23)
		{
			printf("Signal %d would kill the process\n", i);
		}
	       	else
	       	{
			printf("Sending signal number %d to process %u\n", i, pid);
			kill(pid, i);
		}
	}
}
