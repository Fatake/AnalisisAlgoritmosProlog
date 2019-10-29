#include <iostream>
using namespace std;
double potencia(int, int);

int main(){
	int x, y;
	cout << "Introduzca base: ";
	cin >> x;

	do{
		cout << "Introduzca exponente >= 0 : ";
		cin >> y;
	}while(y < 0);

	cout << x << " elevado a " << y << " = " << potencia(x,y) << endl;
}

double potencia(int x, int y){
	double resultado = 1;
	int i;
	for(i = 1;i <= y;i++)
		resultado = resultado * x;
	return resultado;
}

