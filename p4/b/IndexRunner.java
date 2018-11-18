import java.util.*;
import java.io.*;

public class IndexRunner {
    public static void main(String[] args) throws Exception{
        long start = System.currentTimeMillis();
        File[] inputFiles = new File(args[0]).listFiles();
        FileThread[] fileThreads = new FileThread[inputFiles.length];
        File outputDir = new File(args[1]);
        int pageCharacterLength = Integer.parseInt(args[2]);
        int i = 0;
        for (File file : inputFiles) {
            fileThreads[i] = new FileThread(file, outputDir, pageCharacterLength);
            fileThreads[i].start();
            i++;
        }
        for (FileThread ft : fileThreads) {
            if (ft.isAlive()) {
                ft.join();
            }
        }
        long end = System.currentTimeMillis();
        System.out.println("This took: " + (end - start) + " milliseconds.");
    }
}
