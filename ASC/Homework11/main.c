/*
Read from file numbers.txt a string of numbers (positive and negative). Build two strings using read numbers:
P – only with positive numbers
N – only with negative numbers
Display the strings on the screen
*/

#include <stdio.h>
#include <stdlib.h>

int checkPositive(int);

int main()
{
    int P[100], N[100], current_number, i = 0, j = 0, k;
    char str[100];
	FILE *file_pointer;
	file_pointer = fopen("C:/Users/popvl/asm_tools/Homework11/numbers.txt", "r");
	if (!file_pointer)
	    return -1;

	while (!feof(file_pointer))
	{
		fscanf(file_pointer, "%i", &current_number);
		if (checkPositive(current_number) == 1)
		{
			P[i] = current_number;
			i++;
		}
		else
		{
			N[j] = current_number;
			j++;
		}
	}

	for(k = 0; k < i; ++k)
    {
        printf("%i ", P[k]);
    }
    printf("\n");
    for(k = 0; k < j; ++k)
    {
        printf("%i ", N[k]);
    }

	fclose(file_pointer);
	return 0;
}
