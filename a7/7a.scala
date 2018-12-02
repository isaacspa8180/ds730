val wapFile = sc.textFile("wap.txt");
val flattenMap = wapFile.flatMap(line => line.split("\\s+"));
val mapReduce = flattenMap.map(word => (word, 1)).reduceByKey((a, b) => a + b);
val manyWords = mapReduce.filter{case (key, value) => value >= 5 && value <= 7};
manyWords.keys.collect.foreach(println);
