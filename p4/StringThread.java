import java.util.*;
import java.io.*;
import java.nio.file.*;

public class StringThread extends Thread{
    private File file;
    private int pageCharacterLength;

    public StringThread(File file, int pageCharacterLength) {
        this.file = file;
        this.pageCharacterLength = pageCharacterLength;
    }
    private Scanner getScanner(File file){
        try {
            return new Scanner(file);
        } catch (FileNotFoundException e) {
            return null;
        }
    }
    public void run() {
        TreeMap<String, TreeSet<String>> index = new TreeMap<>();
        int characterCount = 0;
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
            //TODO: Have this function format the pages
        }
        GlobalRunner.addIndex(file.getName(), index);
    }
}
