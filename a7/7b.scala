def isVowel(letter: Char): Boolean = {
    letter match {
        case 'a' => true;
        case 'e' => true;
        case 'i' => true;
        case 'o' => true;
        case 'u' => true;
        case _ => false;
    }
}

def makeVowelCombo(word: String): String = {
    return word.filter(letter => isVowel(letter)).sorted
}

val wapFile = sc.textFile("wap.txt");
val flattenMap = wapFile.flatMap(line => line.split("\\s+"));
val vowelComboFlatMap = flattenMap.map(word => makeVowelCombo(word));
val vowelMapReduce = vowelComboFlatMap.map(combo => (combo, 1)).reduceByKey((a, b) => a + b);
val maxVowel = vowelMapReduce.reduce((a, b) => if(a._2 > b._2) a else b);
println(maxVowel._1);
