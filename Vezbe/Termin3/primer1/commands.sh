export CLASSPATH="$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.8.5.jar:$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-common-2.8.5.jar:$HADOOP_HOME/share/hadoop/common/hadoop-common-2.8.5.jar:~/examples/*:$HADOOP_HOME/lib/*"

javac -d . ProcessUnits.java

jar cfm ProcessUnits.jar Manifest.txt *.class

hdfs dfs -put sample.txt /units

hadoop jar ProcessUnits.jar ProcessUnits /units /units_out
