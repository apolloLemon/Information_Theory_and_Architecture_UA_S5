sum=0
int *addr_a=&a[i*N];
int *addr_b=&b[i*N];
for(k=0;k<N;k++){
	sum += (*addr_a)*(*addr_b);
	addr_a++;
	addr_b+=N;	
}