#include <stdio.h>

int main(void)
{
	int c = 0;

	for(int i = 0; i < 16; i++)
	{
		for(int j = 0; j < 16; j++)
		{
		
			printf("\033[38;5;%dmHello World!\t\033[0m", c);
			c++;

			if((j+1) % 8 == 0)
				printf("\n");
			
			if(c == 16 || c == 232)
				printf("\n");
		}
	}
	return 0;
}
