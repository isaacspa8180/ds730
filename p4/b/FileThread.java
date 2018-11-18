import java.util.*;
import java.io.*;
import java.nio.file.*;

public class FileThread extends Thread{
    private File file;
    private File outputDir;
    private int pageCharacterLength;

    public FileThread(File file, File outputDir, int pageCharacterLength) {
        this.file = file;
        this.outputDir = outputDir;
        this.pageCharacterLength = pageCharacterLength;
    }

    private Scanner getScanner(File file){
        try {
            return new Scanner(file);
        } catch (FileNotFoundException e) {
            return null;
        }
    }
    private PrintWriter getPrintWriter(File file){
        try {
            return new PrintWriter(file);
        } catch (FileNotFoundException e) {
            return null;
        }
    }

    public void run() {
        TreeMap<String, TreeSet<Integer>> index = new TreeMap<>();
        int characterCount = 0;
        int pageCount = 1;
        //Scanner input = new Scanner(file);
        Scanner input = getScanner(file);
        while (input.hasNextLine()) {
            String line = input.nextLine();                
            String[] wordList = line.split("\\s+");
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
        //PrintWriter out = new PrintWriter(outputFile);
        PrintWriter out = getPrintWriter(outputFile);
        for (String word : index.keySet()) {
            ArrayList<String> pgNums = new ArrayList<>();
            for (Integer pgNum : index.get(word)) {
               pgNums.add(pgNum.toString()); 
            }
            out.println(word + " " + String.join(", ", pgNums));
            //System.out.println(word + " " + String.join(", ", index.get(word)));
        }
        out.flush();
        out.close();
    }
}
