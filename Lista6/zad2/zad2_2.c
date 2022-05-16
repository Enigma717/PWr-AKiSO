#include <stdio.h>
#include <signal.h>


int main(int argc, char *argv[])
{
	printf("Trying to use SIGHUP\n");
	kill(1, 1);
	printf("Trying to use SIGINT\n");
	kill(1, 2);
	printf("Trying to use SIGQUIT\n");
	kill(1, 3);
	printf("Trying to use SIGFPE\n");
	kill(1, 8);
	printf("Trying to use SIGKILL\n");
	kill(1, 9);
	printf("Trying to use SIGSEGV\n");
	kill(1, 11);
	printf("Trying to use SIGALRM\n");
	kill(1, 14);
	printf("Trying to use SIGTERM\n");
	kill(1, 15);
	printf("Trying to use SIGSTOP\n");
	kill(1, 17);
	kill(1, 19);
	kill(1, 23);

	printf("Seemingly, init is immortal\n");	

	return 0;
}

