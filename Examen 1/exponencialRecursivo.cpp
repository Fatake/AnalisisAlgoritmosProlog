#include <iostream>
using namespace std;
double potencia(int, int);

int main(){
  int x, y;
  cout << "Introduzca base: ";
  cin >> x;

  do{
    cout << "Introduzca exponente >=0 : ";
    cin >> y;
  }while(y < 0);

  cout << x << " elevado a " << y << " = " << potencia(x,y) << endl;
}

double potencia(int x, int y){
  if (y == 0)
    return 1;
  else
    return x*(potencia(x,y-1));
}