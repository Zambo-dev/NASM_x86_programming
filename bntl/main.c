#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>

uint32_t bn_init(char *num_str, uint32_t size);

int main()
{
	char arr[] = "600000000";
	uint32_t retval = bn_init(arr, strlen(arr));
	printf("%u\n", retval);
	printf("%X\n", retval);

	return EXIT_SUCCESS;
}

