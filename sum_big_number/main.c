#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 8

typedef unsigned char byte;

extern int sum(byte* value1, byte* value2, unsigned int size);


int main()
{
	srand(time(NULL));

	byte* val = calloc(SIZE, sizeof(byte));
	byte* val2 = calloc(SIZE, sizeof(byte));
	
	val2[SIZE-1] = 100;

	for(int i=0; i < 100000; i++)
		sum(val, val2, SIZE);	
	
	printf("Val: ");
	for(int i=0; i < SIZE; i++)
		printf("%u ", val[i]);
	printf("\n");
	
	return 0;
}
