#include <stdio.h>

unsigned int popcount(unsigned int x) {
	unsigned int out;
	for(int i=0;i<32;i++)
		if((x&(1<<i))!=0) out++;
	return out;
}

unsigned int popcount_better(unsigned int x) {
	unsigned int out;
	while(x){
		if((x&1)!=0) out++;
		x=x>>1;
	}
}


int main(int argc, char const *argv[])
{
	printf("%d",popcount(0b1001101));
	printf("%d",popcount(1+4+8+64));
	return 0;
}
