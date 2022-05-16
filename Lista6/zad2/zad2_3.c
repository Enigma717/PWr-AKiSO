#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

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

	for(int i = 0; i < 10; i++)
	{
		kill(pid, 10);
		printf("Signal SIGUSR1 sent %d time(s)\n", i+1);
	}

	return 0;
}
