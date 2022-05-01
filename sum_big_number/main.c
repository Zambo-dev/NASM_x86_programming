#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 8

typedef unsigned char byte;

extern int sum(byte* value1, byte* value2, unsigned int size);


int main()
{
	srand(time(NULL));

	byte val[SIZE] = {0};
	byte val2[SIZE] = {0};
	
	val2[SIZE-1] = 100;

	for(int i=0; i < 1000000; i++)	
		sum(val, val2, SIZE);	
	
	printf("Val: ");
	for(int i=0; i < SIZE; i++)		// Result: 0 0 0 0 5 F5 E1 0
		printf("%X ", val[i]);
	printf("\n");
	
	return 0;
}
