#Fatake

def Ackerman( m, n ):
	if (m == 0):
		return n+1

	if(n == 0):
		return Ackerman(m-1,1)

	return Ackerman(m-1, Ackerman(m,n-1))



m = int(input("Por favor ingresa el primer valor: "))

n = int(input("Por favor ingrese el segundo valor: "))

print("El valor Ackerman es: " + str(Ackerman(m,n)))

