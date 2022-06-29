#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>


extern uint32_t xorshift(uint32_t number, uint32_t shift1,
			uint32_t shift2, uint32_t shift3);


int main(int argc, char **argv)
{
	if(argc < 5)
	{
		puts("Missing parameters: <number> <shift1> <shift2> <shift3>");
		return EXIT_FAILURE;
	}

	printf("%d\n", xorshift((int)strtol(argv[1], NULL, 10),
				(int)strtol(argv[2], NULL, 10),
				(int)strtol(argv[3], NULL, 10),
				(int)strtol(argv[4], NULL, 10))
			);

	return EXIT_SUCCESS;	
}

