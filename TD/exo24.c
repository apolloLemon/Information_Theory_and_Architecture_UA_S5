void f(int *v, int *w, int k, int n) {
	int i=0;
	for(;i< (n and ~3);i+=4){ //not 3
		v[i]+=w[i]*k
		v[i+1]+=w[i+1]*k
		v[i+2]+=w[i+2]*k
		v[i+3]+=w[i+3]*k
	}
	while(i<n){
		v[i]+=w[i]*k;
		i++;
	}
}