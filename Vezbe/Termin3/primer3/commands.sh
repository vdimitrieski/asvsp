# omoguciti izvrsivost .py skripti
chmod +x *.py

# dodavanje podataka
hdfs dfs -put ~/input /input

# pokretanje (ukoliko je potrebno, izmeniti apsolutne putanje do .py skripti
hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-2.8.5.jar -input /input -output /output -mapper ~/examples/mapper.py -reducer ~/examples/reducer.py

