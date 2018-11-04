import java.util.*;


public class Third {
    public static void main (String args[]) {
        //ArrayList<Integer> myList = new ArrayList<>();
        //myList.add(4);
        //myList.add(4);
        //myList.add(4);
        //HashSet<Integer> mySet = new HashSet<>();
        //mySet.add(4);
        //mySet.add(4);
        //mySet.add(4);
        //System.out.println("In list:");
        //for (int value : myList) { 
        //    System.out.println(value);
        //}
        //System.out.println("In set:");
        //for (int value : mySet) {
        //    System.out.println(value);
        //}
        //TreeSet<Integer> myTree = new TreeSet<>();
        //for(int i=0; i<100; i+=10){
        //    myTree.add(i);
        //}
        //HashSet<Integer> mySet = new HashSet<>();
        //for(int i=0; i<100; i+=10){
        //    mySet.add(i);
        //}
        //System.out.println("In tree:");
        //for(int value : myTree){
        //    System.out.println(value);
        //}
        //System.out.println("In hash:");
        //for(int value : mySet){
        //    System.out.println(value);
        //}
        HashMap<Integer, String> codes = new HashMap<>();
        codes.put(715, "WI");
        codes.put(319, "IA");
        codes.put(920, "WI");
        Set<Integer> keys = codes.keySet();
        for (Integer key : keys) {
            if (codes.containsKey(key)) {
                System.out.println(key + " : " + codes.get(key));
            }
        }
    }
}
