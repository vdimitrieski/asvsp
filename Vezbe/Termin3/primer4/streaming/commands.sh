chmod +x *.py

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-2.8.5.jar -input /sales -output /sales_type -mapper ~/examples/sales/python/mapper.py -reducer ~/examples/sales/python/reducer.py