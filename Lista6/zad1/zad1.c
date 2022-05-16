#define _GNU_SOURCE
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[]) 
{
	setuid(0);
	system("bash");

	return 0;
}
