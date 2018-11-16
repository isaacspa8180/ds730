import java.util.*;
import java.io.*;

public class GlobalRunner {
    public static TreeMap<String, TreeMap<String, String>> indexes = new TreeMap<>();
    public synchronized static void addIndex(String filename, TreeMap<String, String> index) {
        indexes.put(filename, index);
    }
    public static void main(String[] args) throws InterruptedException{
        int pageCharacterLength = Integer.parseInt(args[2]);
        File[] inputFiles = new File(args[0]).listFiles();
        StringThread[] stringThreads = new StringThread[inputFiles.length];
        int i = 0;
        for (File file : inputFiles) {
            stringThreads[i] = new StringThread(file, pageCharacterLength);
            stringThreads[i].start();
            i++;
        }
        for (StringThread st : stringThreads) {
            if (st.isAlive()) {
                st.join();
            }
        }
        TreeSet<String> globalWordSet = new TreeSet<>();
        for (String filename : indexes.keySet()) {
            TreeMap<String, String> index = indexes.get(filename);
            for (String word : index.keySet()) {
                globalWordSet.add(word);
            }
        }
        for (String globalWord : globalWordSet) {
            ArrayList<String> pgNumsList = new ArrayList<>();
            for (String filename : indexes.keySet()) {
                String pgNums;
                if ((pgNums = indexes.get(filename).get(globalWord)) != null) {
                    pgNumsList.add(pgNums);
                } else {
                    pgNumsList.add(" ");
                }
            }
            String globalPageNums = String.join(",", pgNumsList);
            // TODO: Change this to write to a file.
            System.out.println(globalWord + " " + globalPageNums);
        }
        File outputDir = new File(args[1]);
    }
}
