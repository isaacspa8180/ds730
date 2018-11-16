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
        TreeMap<String, TreeSet<String>> index = new TreeMap<>();
        int characterCount = 0;
        //Scanner input = new Scanner(file);
        Scanner input = getScanner(file);
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
        //PrintWriter out = new PrintWriter(outputFile);
        PrintWriter out = getPrintWriter(outputFile);
        for (String word : index.keySet()) {
            Iterable<String> pageNumbers = index.get(word);
            out.println(word + " " + String.join(", ", pageNumbers));
            //System.out.println(word + " " + String.join(", ", index.get(word)));
        }
        out.flush();
        out.close();
    }
}
