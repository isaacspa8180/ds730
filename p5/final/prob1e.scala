import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.expressions.Window

val spark: SparkSession = SparkSession.builder.master("local").getOrCreate

var oshkosh = spark.read
  .option("header", "true")
  .option("inferSchema", "true")
  .csv("/user/maria_dev/final/Oshkosh")
  .filter("TemperatureF != -9999")
  .withColumn("uxt", unix_timestamp(concat($"Year", lit("-"), $"Month", lit("-"), $"Day", lit(" "), $"TimeCST"), "yyyy-M-d h:m a")) 

var iowacity = spark.read
  .option("header", "true")
  .option("inferSchema", "true")
  .csv("/user/maria_dev/final/IowaCity")
  .filter("TemperatureF != -9999")
  .withColumn("uxt", unix_timestamp(concat($"Year", lit("-"), $"Month", lit("-"), $"Day", lit(" "), $"TimeCST"), "yyyy-M-d h:m a"))

val w = Window
  .orderBy($"uxt")
  .rangeBetween(-(60*60*24), Window.currentRow)

oshkosh = oshkosh
  .withColumn("min24", min($"TemperatureF").over(w))
  .withColumn("max24", max($"TemperatureF").over(w))
  .withColumn("diff24", $"max24" - $"min24")

iowacity = iowacity
  .withColumn("min24", min($"TemperatureF").over(w))
  .withColumn("max24", max($"TemperatureF").over(w))
  .withColumn("diff24", $"max24" - $"min24")

oshkosh.agg(max("diff24")).show
iowacity.agg(max("diff24")).show

iowacity.where("diff24 == 56.2").show
iowacity.where("Year == 2008 and Month == 12 and Day >= 14 and Day <= 16").show
