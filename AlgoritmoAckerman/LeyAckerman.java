//Fatake
import java.util.Scanner;

public class LeyAckerman {

	private Scanner entrada = new Scanner(System.in);

	private int Ackerman(int m, int n){
		if (m == 0)
			return n+1;

		if(n == 0)
			return Ackerman(m-1,1);

		return Ackerman(m-1, Ackerman(m,n-1));
	}

	public static void main (String[] args){
		LeyAckerman aux = new LeyAckerman();
		int m, n;

		System.out.println("Por favor ingresa el primer valor: ");
		m = aux.entrada.nextInt();

		System.out.println("Por favor ingrese el segundo valor: ");
		n = aux.entrada.nextInt();

		System.out.println("El valor Ackerman es: " + aux.Ackerman(m,n));
	}
}

