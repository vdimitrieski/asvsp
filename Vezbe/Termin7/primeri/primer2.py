from pyspark import SparkContext, SparkConf

conf = SparkConf().setAppName("wordcount").setMaster("local")
sc = SparkContext(conf=conf)

text_file = sc.textFile("hdfs://namenode:8020/dante/divine_comedy.txt")
counts = text_file.flatMap(lambda line: line.split(" ")).map(lambda word: ("avg", [len(word), 1])).reduceByKey(lambda a, b: [a[0] + b[0], a[1] + b[1]])
counts.saveAsTextFile("hdfs://namenode:8020/dante/avg")
