export HDFS_ROOT=${HDFS_ROOT:-hdfs:/tmp/${USER}}
hdfs dfs -ls $HDFS_ROOT 2>&1 > /dev/null
if [ $? != 0 ]; then
    HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p ${HDFS_ROOT}
    HADOOP_USER_NAME=hdfs hdfs dfs -chown ${USER} ${HDFS_ROOT}
fi

