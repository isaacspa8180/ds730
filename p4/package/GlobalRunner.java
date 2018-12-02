import java.util.*;
import java.io.*;
import java.nio.file.*;


public class GlobalRunner {
    public static TreeMap<String, TreeMap<String, String>> indexes = new TreeMap<>();
    public synchronized static void addIndex(String filename, TreeMap<String, String> index) {
        indexes.put(filename, index);
    }
    public static void main(String[] args) throws InterruptedException, FileNotFoundException{
        long start = System.currentTimeMillis();
        File[] inputFiles = new File(args[0]).listFiles();
        int pageCharacterLength = Integer.parseInt(args[2]);
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
        File outputDir = new File(args[1]);
        if (! outputDir.isDirectory()) {
            outputDir.mkdir();
        }
        File outputFile = Paths.get(outputDir.getName(), "output.txt").toFile();
        PrintWriter out = new PrintWriter(outputFile);
        //write header
        out.println("Word, " + String.join(", ", indexes.keySet()));
        //writer body
        for (String globalWord : globalWordSet) {
            ArrayList<String> pgNumsList = new ArrayList<>();
            for (String filename : indexes.keySet()) {
                String pgNums;
                if ((pgNums = indexes.get(filename).get(globalWord)) != null) {
                    pgNumsList.add(" " + pgNums);
                } else {
                    pgNumsList.add(" ");
                }
            }
            String globalPageNums = String.join(",", pgNumsList);
            out.println(globalWord + "," + globalPageNums);
        }
        out.flush();
        out.close();
        long end = System.currentTimeMillis();
        System.out.println("This took: " + (end - start) + " milliseconds.");
    }
}
