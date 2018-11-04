import java.util.*;
import java.io.*;
public class Forth {
    public static void main (String args[]) throws Exception {
        Scanner input = new Scanner(new File("temp.txt"));
        ArrayList<Integer> values = new ArrayList<>();
        while (input.hasNext()) {
            int temp = input.nextInt();
            values.add(temp);
        }
        int total = 0;
        for (int value : values) {
            total += value;
        }
        double average = total / (double)values.size();
        System.out.println(average);
    }
}
