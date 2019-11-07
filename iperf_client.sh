#!/bin/bash
#设置时间变量，格式为YY-MM-DD_HH-MM
time=$(date "+%Y-%m-%d_%H:%M")
#客户端开始记录数据，保存在/root/iperf_history，“iperf_hostory”目录需要给可写权限，建议直接chmod 777 iperf_hostory
iperf3 -c 182.92.82.109 -p 4050 -i 60 -u -b 5M -t 3420 --logfile /root/iperf_history/${time}.txt
#这行也可以写成iperf3 -c 182.92.82.109 -p 4050 -i 60 -u -b 5M -t 3420 > /root/iperf_history/${time}.txt
