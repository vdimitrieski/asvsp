# podesavanje java classpath kako bi pri kompajliranju bilo moguce locirati hadoop biblioteke
export CLASSPATH="$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.8.5.jar:$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-common-2.8.5.jar:$HADOOP_HOME/share/hadoop/common/hadoop-common-2.8.5.jar:~/examples/*:$HADOOP_HOME/lib/*"

# kompajliranje java aplikacije
javac -d . ProcessUnits.java 

# pakovanje aplikacije u JAR (u Manifest.txt pise koja klasa sadrzi main)
jar cfm ProcessUnits.jar Manifest.txt *.class

# prebacivanje podataka na hdfs
hdfs dfs -put sample.txt /units

# pokretanje primera
hadoop jar ProcessUnits.jar ProcessUnits /units /units_out
