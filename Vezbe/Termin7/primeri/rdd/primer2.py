#!/usr/bin/python3

import os
from pyspark import SparkContext, SparkConf

HDFS_NAMENODE = os.environ["CORE_CONF_fs_defaultFS"]

conf = SparkConf().setAppName("wordmean").setMaster("local")
sc = SparkContext(conf=conf)

text_file = sc.textFile(HDFS_NAMENODE + "/dante/divine_comedy.txt")
counts = text_file.flatMap(lambda line: line.split(" ")) \
    .map(lambda word: ("avg", [len(word), 1])) \
    .reduceByKey(lambda a, b: [a[0] + b[0], a[1] + b[1]])
counts.saveAsTextFile(HDFS_NAMENODE + "/dante/mean")
