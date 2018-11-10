# podesavanje java classpath kako bi pri kompajliranju bilo moguce locirati hadoop biblioteke
export CLASSPATH="$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.8.5.jar:$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-common-2.8.5.jar:$HADOOP_HOME/share/hadoop/common/hadoop-common-2.8.5.jar:~/examples/*:$HADOOP_HOME/lib/*"

# kompajliranje java aplikacije
javac -d . SalesMapper.java SalesCountryReducer.java SalesCountryDriver.java

# pakovanje aplikacije u JAR (u Manifest.txt pise koja klasa sadrzi main)
jar cfm ProductSalePerCountry.jar Manifest.txt SalesCountry/*.class

# prebacivanje podataka na hdfs
hdfs dfs -mkdir /sales
hdfs dfs -put SalesJan2009.csv /sales

# pokretanje primera
hadoop jar ProductSalePerCountry.jar SalesCountry.SalesCountryDriver /sales /sales_out
