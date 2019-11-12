#!/bin/bash
#设置时间变量，格式为YY-MM-DD_HH-MM
time=$(date "+%Y-%m-%d_%H:%M")
#杀掉叫iperf3的进程
killall -9 iperf3
#服务端开始记录数据，保存在/root/iperf_history，“iperf_hostory”目录需要给可写权限，建议直接chmod 777 iperf_hostory
iperf3 -s -p 4050 -i 60 --logfile /root/iperf_history/${time}.txt
#这行也可以写成iperf3 -s -p 4050 -i 60 > /root/iperf_history/${time}.txt
