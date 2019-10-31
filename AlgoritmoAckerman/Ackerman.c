#include <stdio.h>
#define M 4
#define N 1

int Ackerman(int m, int n){
	if (m == 0)
		return n+1;

	if(n == 0)
		return Ackerman(m-1,1);

	return Ackerman(m-1, Ackerman(m,n-1));
}

int main(int argc, char **argv){
	printf("Ackerman\n");
	printf("El valor Ackerman (%d,%d) es = %d\n",M, N, Ackerman(M,N));
	return 0;
}
