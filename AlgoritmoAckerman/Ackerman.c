#include <stdio.h>


int Ackerman(int m, int n){
	if (m == 0)
		return n+1;

	if(n == 0)
		return Ackerman(m-1,1);

	return Ackerman(m-1, Ackerman(m,n-1));
}

int main(int argc, char **argv){
	int m, n;
	printf("Por favor ingresa el primer valor: \n->");
	scanf("%d",&m);

	printf("Por favor ingrese el segundo valor: \n->");
	scanf("%d",&n);

	printf("El valor Ackerman es: %d\n", Ackerman(m,n));
	return 0;
}
