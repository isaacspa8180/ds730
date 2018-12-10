import org.apache.spark.sql.expressions.Window
//-----------------------------------------------------------------------------
// Question 1
//-----------------------------------------------------------------------------
val df = spark.read
  .option("header", "true")
  .option("inferSchema", "true")
  .csv("/user/maria_dev/final/tycho.csv")
  .withColumn("Year", year($"PeriodStartDate"))


var a  = df
  .select($"Year", $"ConditionName", $"CountValue")
  .groupBy($"Year", $"ConditionName")
  .agg(sum($"CountValue") as "ConditionCount")

val w = Window
  .partitionBy($"ConditionName")
  .orderBy($"Year")
  .rangeBetween(-10, Window.currentRow)

a = a
  .withColumn("minDecade", min($"ConditionCount").over(w))
  .withColumn("maxDecade", max($"ConditionCount").over(w))
  .withColumn("diffDecade", $"maxDecade" - $"minDecade")

a.groupBy($"ConditionName").agg(max($"diffDecade")).show()

a
  .filter($"ConditionName" === "Influenza" && $"Year" >= 1918 && $"Year" <= 1929)
  .sort($"Year".asc)
  .show

//-----------------------------------------------------------------------------
// Question 2
//-----------------------------------------------------------------------------
val df = spark.read
  .option("header", "true")
  .option("inferSchema", "true")
  .csv("/user/maria_dev/final/tycho.csv")
  .withColumn("Year", year($"PeriodStartDate"))

var b = df
  .select($"Year", $"Admin1Name".alias("State"), $"ConditionName", $"CountValue")
  .groupBy($"Year", $"State", $"ConditionName")
  .agg(sum($"CountValue") as "ConditionCount")

val pop = spark.read
  .option("header", "true")
  .option("inferSchema", "true")
  .csv("/user/maria_dev/final/pop.csv")

b  = b.join(pop, 
  b("State") <=> upper(pop("State"))
  && b("Year") <=> pop("Year"))
  .select(pop("Year"), pop("State"), b("ConditionName"), b("ConditionCount"), pop("Count").alias("TotalCount"))
  .withColumn("ConditionPercent", $"ConditionCount" / $"TotalCount")
b.agg(max($"ConditionPercent")).show

b.where($"ConditionPercent" === 0.03999382166415293).show

//-----------------------------------------------------------------------------
// Question 3
//-----------------------------------------------------------------------------
val df = spark.read
  .option("header", "true")
  .option("inferSchema", "true")
  .csv("/user/maria_dev/final/tycho.csv")
  .withColumn("Year", year($"PeriodStartDate"))

var c = df
  .select($"Year", $"Admin1Name".alias("State"), $"ConditionName", $"CountValue")
  .groupBy($"Year", $"State", $"ConditionName")
  .agg(sum($"CountValue") as "ConditionCount")

val pop = spark.read
  .option("header", "true")
  .option("inferSchema", "true")
  .csv("/user/maria_dev/final/pop.csv")

c  = c.join(pop, 
  c("State") <=> upper(pop("State"))
  && c("Year") <=> pop("Year"))
  .select(pop("Year"), pop("Region"), c("ConditionName"), c("ConditionCount"), pop("Count").alias("TotalCount"))
  .groupBy($"Year", $"Region", $"ConditionName")
  .agg(sum($"ConditionCount") as "ConditionCount", sum($"TotalCount") as "TotalCount")
  .withColumn("ConditionPercent", $"ConditionCount" / $"TotalCount")

val w2 = Window
  .partitionBy($"Year", $"ConditionName")
  .orderBy($"Year")

c = c
  .withColumn("minYear", min($"ConditionPercent").over(w2))
  .withColumn("maxYear", max($"ConditionPercent").over(w2))
  .withColumn("diffYear", $"maxYear" - $"minYear")

c.agg(max($"diffYear")).show

c.where($"diffYear" === 0.009920056671075822).show
