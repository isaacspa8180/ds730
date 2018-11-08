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
            TreeMap<String, TreeSet<String>> index = new TreeMap<>();
            int characterCount = 0;
            Scanner input = new Scanner(file);
            while (input.hasNextLine()) {
                String line = input.nextLine();                
                String[] wordList = line.split("\\s+");
                for (String word : wordList) {
                    word = word.toLowerCase();
                    characterCount += word.length();
                    Integer currentPage = characterCount / pageCharacterLength;
                    if (index.get(word) == null) {
                        index.put(word, new TreeSet<>());
                    }
                    index.get(word).add(currentPage.toString());
                }
            }
            if (! outputDir.isDirectory()) {
                outputDir.mkdir();
            }
            File outputFile = Paths.get(outputDir.getName(), 
                                        file.getName().replace(".txt", "_output.txt")).toFile();
            PrintWriter out = new PrintWriter(outputFile);
            for (String word : index.keySet()) {
                Iterable<String> pageNumbers = index.get(word);
                out.println(word + " " + String.join(", ", pageNumbers));
                //System.out.println(word + " " + String.join(", ", index.get(word)));
            }
            out.flush();
            out.close();
        }
        long end = System.currentTimeMillis();
        System.out.println("This took: " + (end - start) + " milliseconds.");
    }
}
