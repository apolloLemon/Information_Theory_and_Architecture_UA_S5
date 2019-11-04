#include <stdio.h>
#include <stdlib.h>
#define N 64*2000

int *tab1;
int *tab2;

// ========================================================
// main function
// ========================================================
int main(int argc, char *argv[]) {
	int maxi = atoi(argv[1]);
	int number;
	int j;

	tab1 = (int *) malloc(N*sizeof(int));
	tab2 = (int *) malloc(N*sizeof(int));

	for (number = 1; number <= maxi; ++number) {
		for (j=0; j<N; ++j) {
			tab2[j] = tab1[j];
		}
	}

	free(tab1);
	free(tab2);

	printf("iterations = %d\n", number);

	return 0;
}