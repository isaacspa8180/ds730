import java.util.*;
import java.io.*;
import java.nio.file.*;

public class Index{
    public static void main(String[] args) throws Exception{
        long start = System.currentTimeMillis();
        File[] inputFiles = new File(args[0]).listFiles();
        int pageCharacterLength = Integer.parseInt(args[2]);
        File outputDir = new File(args[1]);
        for (File file : inputFiles) {
            TreeMap<String, TreeSet<Integer>> index = new TreeMap<>();
            int characterCount = 0;
            int pageCount = 1;
            Scanner input = new Scanner(file);
            while (input.hasNextLine()) {
                String line = input.nextLine();                
                String[] wordList = line.trim().split("\\s+");
                for (String word : wordList) {
                    if (word.length() == 0) {
                        continue;
                    }
                    word = word.toLowerCase();
                    characterCount += word.length();
                    if (characterCount > pageCharacterLength) {
                        pageCount += 1;
                        characterCount = word.length();
                    }
                    if (index.get(word) == null) {
                        index.put(word, new TreeSet<>());
                    }
                    index.get(word).add(pageCount);
                }
            }
            if (! outputDir.isDirectory()) {
                outputDir.mkdir();
            }
            File outputFile = Paths.get(outputDir.getName(), 
                                        file.getName().replace(".txt", "_output.txt")).toFile();
            PrintWriter out = new PrintWriter(outputFile);
            for (String word : index.keySet()) {
                ArrayList<String> pgNums = new ArrayList<>();
                for (Integer pgNum : index.get(word)) {
                   pgNums.add(pgNum.toString()); 
                }
                out.println(word + " " + String.join(", ", pgNums));
            }
            out.flush();
            out.close();
        }
        long end = System.currentTimeMillis();
        System.out.println("This took: " + (end - start) + " milliseconds.");
    }
}
