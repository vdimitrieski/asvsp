#!/bin/bash
cd example2

printf "\nCOPY FILE TO HDFS\n"

hdfs dfs -put SalesJan2009.csv /sales

printf "\nSET CLASSPATHS\n"

export CLASSPATH="$HADOOP_PREFIX/share/hadoop/mapreduce/hadoop-mapreduce-client-core-$HADOOP_VERSION.jar:$HADOOP_PREFIX/share/hadoop/mapreduce/hadoop-mapreduce-client-common-$HADOOP_VERSION.jar:$HADOOP_PREFIX/share/hadoop/common/hadoop-common-$HADOOP_VERSION.jar:~/example2/*:$HADOOP_PREFIX/lib/*"

printf "\nCOMPILE JAVA\n"

javac -d . src/*.java

printf "\nBUILD JAR\n"

jar cfm ProductSalePerCountry.jar src/Manifest.txt SalesCountry/*.class

printf "\nRUN MAP-REDUCE\n"

hadoop jar ProductSalePerCountry.jar SalesCountry.SalesCountryDriver /sales /sales_out

printf "\nRESULTS\n"

hdfs dfs -cat /sales_out/*