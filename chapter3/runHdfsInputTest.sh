#!/bin/sh

. $(dirname $0)/../hdfs-root-env.sh

# issues with file collisions on case-insensitive file system when exploded locally before shipped
# to hadoop
zip -dq target/chapter3-0-jar-with-dependencies.jar META-INF/LICENSE 2>&1 1>/dev/null

hdfs dfs -rm -r -f -skipTrash ${HDFS_ROOT}/result

hadoop jar target/chapter3-0-jar-with-dependencies.jar  com.twitter.scalding.Tool hdfsInputTest \
    --hdfs --input ${HDFS_ROOT}/dataset/*/*/* --output ${HDFS_ROOT}/result/

hadoop fs -cat ${HDFS_ROOT}/result/*