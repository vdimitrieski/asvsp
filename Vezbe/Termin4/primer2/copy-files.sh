#!/bin/bash
docker exec -it resourcemanager bash -c "rm -rf /example2"
docker cp . resourcemanager:/example2/
docker exec -it resourcemanager bash -c "chmod +x /example2/compile-and-run-mr.sh && /example2/compile-and-run-mr.sh"
# docker exec -it resourcemanager bash -c "hdfs dfs -rm -r -f /sales*"