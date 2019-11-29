#!/usr/bin/python
### before spark-submit: export PYTHONIOENCODING=utf8

from pyspark import SparkContext, SparkConf
from pyspark.sql import SparkSession
from pyspark.sql.types import *

def quiet_logs(sc):
  logger = sc._jvm.org.apache.log4j
  logger.LogManager.getLogger("org"). setLevel(logger.Level.ERROR)
  logger.LogManager.getLogger("akka").setLevel(logger.Level.ERROR)

conf = SparkConf().setAppName("uni").setMaster("local")
sc = SparkContext(conf=conf)
spark = SparkSession(sc)

quiet_logs(spark)

from pyspark.sql.types import *

schemaString = "id nazivu univerzitet naziv nivo trajanje polje zvanje skolarina skolarina2 \
                bs1 bs2 bs3 bs4 bs5 bs6 bs ss1 ss2 ss3 ss4 ss5 ss6 ss \
                sss1 sss2 sss3 sss4 sss5 sss6 sss studenata zstudenata espb_budzet espb_samo"
fields = [StructField(field_name, StringType(), True) for field_name in schemaString.split()]
schema = StructType(fields)

df = spark.read.csv("hdfs://namenode:9000/mpn/sprogrami2016.csv", header=True, mode="DROPMALFORMED", schema=schema)

# df.printSchema()

df = df.withColumn("studenata", df["studenata"].cast(IntegerType()))
df.groupBy('univerzitet').sum('studenata').show(20, False)
df.groupBy('polje').sum('studenata').show()

df.createOrReplaceTempView("sprogrami")

query = "SELECT univerzitet, nazivu, sum(studenata) brstud \
         FROM sprogrami \
         GROUP BY univerzitet, nazivu \
         ORDER BY brstud DESC \
         LIMIT 15"
sqlDF = spark.sql(query)
sqlDF.show(20, False)


