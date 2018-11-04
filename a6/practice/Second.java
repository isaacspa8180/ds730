import java.util.*;


public class Second {
    //public static void factorial () {
    //    Scanner input = new Scanner (System.in);
    //    System.out.print("Enter number: ");
    //    int value = input.nextInt();
    //    while (value < 0) {
    //        System.out.print("Enter in a positive number: ");
    //        value = input.nextInt();
    //    }
    //    int answer = 1;
    //    for (int i = 1; i <= value; i++) {
    //        answer = answer * i;
    //    }
    //    System.out.println("Factorial of " + value + " is " + answer);
    //}
    public static int factorial (int value) {
        int answer = 1;
        for (int i = 1; i <= value; i++) {
            answer = answer * i;
        }
        return answer;
    }
    public static void main (String args[]) {
        //System.out.print("Enter a number: ");
        //Scanner input = new Scanner (System.in);
        //int number = input.nextInt();
        //System.out.println("Value was: " + number);
        //if (number < 0) {
        //    System.out.println("Number was negative.");
        //} else if (number == 0) {
        //    System.out.println("Number was 0.");
        //} else {
        //    System.out.println("Number was positive.");
        //}
        //while (number > 0) {
        //    System.out.println(number);
        //    number--;
        //}
        //for (int count = 0; count < number; count++) { 
        //    System.out.println(count);
        //}
        //System.out.print("How many numbers: ");
        //Scanner input = new Scanner (System.in);
        //int size = input.nextInt();
        //ArrayList<Integer> values = new ArrayList<>();
        //for (int count = 0; count < size; count++) {
        //    System.out.print("Enter value " +  (count + 1) + ": ");
        //    int temp = input.nextInt();
        //    values.add(temp);
        //}
        //for (int value: values) {
        //    System.out.println(value);
        //}
        //factorial();
        //factorial();
        //factorial();
        int returnedValue = factorial(6);
        System.out.println(returnedValue);
    }
}
