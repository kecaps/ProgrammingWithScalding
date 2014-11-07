#!/bin/sh

HDFS_ROOT=${HDFS_ROOT:-hdfs:/tmp/${USER}}
hdfs dfs -ls $HDFS_ROOT 2>&1 > /dev/null
if [ $? != 0 ]; then
    HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p ${HDFS_ROOT}
    HADOOP_USER_NAME=hdfs hdfs dfs -chown ${USER} ${HDFS_ROOT}
fi

echo This is a happy day. A day to remember > input.txt
hdfs dfs -rm -f -r -skipTrash  ${HDFS_ROOT}/input ${HDFS_ROOT}/output
hdfs dfs -mkdir -p ${HDFS_ROOT}/input ${HDFS_ROOT}/output
hdfs dfs -put input.txt ${HDFS_ROOT}/input/

hadoop jar target/chapter2-0-jar-with-dependencies.jar com.twitter.scalding.Tool WordCountJob \
    --hdfs --input ${HDFS_ROOT}/input --output ${HDFS_ROOT}/output

hdfs dfs -cat ${HDFS_ROOT}/input/*
hdfs dfs -cat ${HDFS_ROOT}/output/*
