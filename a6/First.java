import java.util.*;


public class First {
    public static boolean isPrime(int value) {
        int i = 2;
        while (i < value) {
            if (value % i == 0) {
                return false;
            }
            i++;
        }
        return true;
    }
    public static void printPrime(int first, int second) {
        int maxNumber = Math.max(first, second); 
        int minNumber = Math.min(first, second); 
        ArrayList<Integer> primes = new ArrayList<>();
        for (int i = minNumber + 1; i < maxNumber; i++) {
            if (isPrime(i)) {
                primes.add(i);
            }
        }
        if (primes.isEmpty()) {
            System.out.print("No primes.");
        } else {
            for (int prime : primes) {
                System.out.print(prime + " ");
            }
        }
    }
    public static void main(String args[]) {
        System.out.println("Enter number 1: ");  
        Scanner input  = new Scanner(System.in);
        int first = input.nextInt();
        while (first < 0) {
            System.out.print("Enter in a positive number: ");
            first = input.nextInt();
        }
        System.out.println("Enter number 2: ");  
        int second = input.nextInt();
        while (second < 0) {
            System.out.print("Enter in a positive number: ");
            second = input.nextInt();
        }
        printPrime(first, second);
    }
}
