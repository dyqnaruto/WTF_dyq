#!/bin/sh
#抄别个大佬的

#想要杀死的进程，用ps -ef | grep iperf，过滤可以看到当前shell进程id
NAME=./iperf_server.sh    
#显示这个进行关键字
echo $NAME
#过滤进程ID
ID=`ps -ef | grep "$NAME" | grep -v "grep" | awk '{print $2}'`
#显示进程ID
echo $ID
#显示一行---
echo "---------------"
#开启循环杀进程
for id in $ID
do
kill -9 $id
echo "killed $id"
done
