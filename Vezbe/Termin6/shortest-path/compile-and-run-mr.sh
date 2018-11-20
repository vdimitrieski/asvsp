DIR=/shpath

cd $DIR

printf "\nCOPY FILE TO HDFS\n"

$HADOOP_PREFIX/bin/hdfs dfs -rm -r -f /shpath_1/

$HADOOP_PREFIX/bin/hdfs dfs -mkdir /shpath_1/
$HADOOP_PREFIX/bin/hdfs dfs -put data.txt /shpath_1

printf "\nSETTING EXECUTEABLE PY\n"

chmod a+x *.py

cd $HADOOP_PREFIX

for i in 1 2 3 4
do
    $HADOOP_PREFIX/bin/hdfs dfs -rm -r -f "/shpath_$(($i+1))/"

    printf "\nRUN HADOOP-STREAMING\n"

    bin/hadoop jar share/hadoop/tools/lib/hadoop-streaming-$HADOOP_VERSION.jar \
        -input "/shpath_$i/" \
        -output "/shpath_$(($i+1))/" \
        -mapper /shpath/mapper.py \
        -reducer /shpath/reducer.py

    printf "\nRESULTS $i\n"

    $HADOOP_PREFIX/bin/hdfs dfs -cat "/shpath_$(($i+1))/*"
done