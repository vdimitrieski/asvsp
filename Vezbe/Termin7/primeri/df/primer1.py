#!/usr/bin/python

from pyspark import SparkContext, SparkConf
from pyspark.sql import SparkSession, Row
from pyspark.sql.functions import col

def quiet_logs(sc):
  logger = sc._jvm.org.apache.log4j
  logger.LogManager.getLogger("org"). setLevel(logger.Level.ERROR)
  logger.LogManager.getLogger("akka").setLevel(logger.Level.ERROR)

conf = SparkConf().setAppName("wordcount").setMaster("local")
sc = SparkContext(conf=conf)
spark = SparkSession(sc)

quiet_logs(spark)

textFile = spark.sparkContext.textFile("hdfs://namenode:9000/dante/divine_comedy.txt")

# Creates a DataFrame having a single column named "line"
df = textFile.map(lambda r: Row(r)).toDF(["line"])
virgil = df.filter(col("line").like("%Virgil%"))
print(virgil.count())
print(virgil.filter(col("line").like("%me%")).count())
print(virgil.filter(col("line").like("%me%")).show())
print(virgil.filter(col("line").like("%me%")).collect())