DIR=/example3

cd $DIR

printf "\nCOPY FILE TO HDFS\n"

$HADOOP_PREFIX/bin/hdfs dfs -put dq.txt /book

printf "\nSETTING EXECUTEABLE PY\n"

chmod a+x *.py

cd $HADOOP_PREFIX

printf "\nRUN HADOOP-STREAMING\n"

bin/hadoop jar share/hadoop/tools/lib/hadoop-streaming-$HADOOP_VERSION.jar \
    -input /book \
    -output /book_out \
    -mapper $DIR/mapper.py \
    -reducer $DIR/reducer.py

printf "\nRESULTS\n"

$HADOOP_PREFIX/bin/hdfs dfs -cat /book_out/*