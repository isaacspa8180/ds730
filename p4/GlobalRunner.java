import java.util.*;
import java.io.*;

public class GlobalRunner {
    public static TreeMap<String, TreeMap<String, TreeSet<String>>> indexes = new TreeMap<>();
    public synchronized static void addIndex(String filename, TreeMap<String, TreeSet<String>> index) {
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
        //TODO: Final structure should be Treemap<String, String[numeberfiles]. The first being the word, the second being an empty array of each files results. You should then replace the ones in there with the right content.
        for (String filename : indexes.keySet()) {
            for (String word : indexes.get(filename).keySet()) {
                System.out.println(word);
            }
        }
        File outputDir = new File(args[1]);
    }
}
