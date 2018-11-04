import java.util.*;
import java.io.*;


public class Second {
    public static void main (String args[]) throws Exception {
        Scanner input = new Scanner(new File("input.txt"));
        ArrayList<Integer> values = new ArrayList<>();
        while (input.hasNext()) {
            int temp = input.nextInt();
            values.add(temp);
        }
        Collections.sort(values);
        int middle = values.size() / 2;
        int median = 0;
        if (values.size() % 2 == 1) {
            median =  values.get(middle);
        } else {
            median = (values.get(middle - 1) + values.get(middle)) / 2;
        }
        System.out.println(median);
    }
}
