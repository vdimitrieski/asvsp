#!/usr/bin/python

from pyspark import SparkContext, SparkConf
from pyspark.sql import SparkSession


def quiet_logs(sc):
    logger = sc._jvm.org.apache.log4j
    logger.LogManager.getLogger("org"). setLevel(logger.Level.ERROR)
    logger.LogManager.getLogger("akka").setLevel(logger.Level.ERROR)


conf = SparkConf().setAppName("example join").setMaster("spark://spark-master:7077")
sc = SparkContext(conf=conf)
spark = SparkSession(sc)

quiet_logs(spark)

employees = sc.parallelize([("Rafferty", 31), ("Jones", 33), ("Heisenberg", 33), \
    ("Robinson", 34), ("Smith", 34), ("Williams", None)]).toDF(["LastName", "DepartmentID"])

employees.show()

departments = sc.parallelize([(31, "Sales"), (33, "Engineering"), \
    (34, "Clerical"), (35, "Marketing")]).toDF(["DepartmentID", "DepartmentName"])

departments.show()

# inner join
employees.join(departments, "DepartmentID").show()

# left outer join
employees.join(departments, ["DepartmentID"], "left_outer").show()

# right outer join
employees.join(departments, ["DepartmentID"], "right_outer").show()

# cartesian join
employees.crossJoin(departments).show(10)


products = sc.parallelize([ \
  ("steak", "1990-01-01", "2000-01-01", 150), \
  ("steak", "2000-01-02", "2020-01-01", 180), \
  ("fish", "1990-01-01", "2020-01-01", 100) \
]).toDF(["name", "startDate", "endDate", "price"])

products.show()

orders = sc.parallelize([ \
  ("1995-01-01", "steak"), \
  ("2000-01-01", "fish"), \
  ("2005-01-01", "steak") \
]).toDF(["date", "product"])

orders.show()

orders.join(products, (orders["product"] == products["name"]) \
    & (orders["date"] >= products["startDate"]) \
    & (orders["date"] <= products["endDate"])).show()