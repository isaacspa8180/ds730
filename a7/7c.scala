import org.apache.spark.rdd.RDD; 
def wordCount(filename: String): RDD[(String, Int)] = { 
    val commonWords = sc.textFile("common.txt").flatMap(line => line.toLowerCase().split("\\s+")); 
    val file = sc.textFile(filename); 
    val allWords = file.flatMap(line => line.toLowerCase().split("\\s+")); 
    val uncommonWords = allWords.subtract(commonWords); 
    return uncommonWords.map(word => (word, 1)).reduceByKey((a, b) => a + b); 
} 
 
def similarWord(fileOne: String, fileTwo: String): Unit = { 
    val inBoth = wordCount(fileOne).join(wordCount(fileTwo)); 
    val minCountInBoth = inBoth.map{case (k, (v1, v2)) => (k, v1.min(v2))};  
    val maxOfMinCount = minCountInBoth.filter{case (k, v) => k != ""}.reduce((a, b) => if (a._2 > b._2) a else b); 
    println(maxOfMinCount._1); 
}
