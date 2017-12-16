#!/bin/sh
#本脚本路径为/jffs/scripts/ntpup.sh
[ "$(ps |grep -w "ntpup.sh"|grep -cv grep)" -ge 3 ] && {
	exit
}

#更新系统时间
echo $(date +%b\ %d\ %X): -----------ntp update start!!!------------ >> /tmp/syslog.log
#时间服务器列表，可自由增减，第一个跟第二个是系统默认内置的时间服务器数据
ntp_server_list="
$(nvram get ntp_server0)
$(nvram get ntp_server1)
time1.aliyun.com
time.windows.com
time.ustc.edu.cn
time7.aliyun.com
time.pool.aliyun.com
ntp1.aliyun.com
time.nasa.gov
time.asia.apple.com
ntp5.aliyun.com
cn.ntp.org.cn
"
#202.120.2.101
echo $(date +%b\ %d\ %X) ntp_server0:$(nvram get ntp_server0)! >> /tmp/syslog.log
echo $(date +%b\ %d\ %X) ntp_server1:$(nvram get ntp_server1)! >> /tmp/syslog.log
if [ "$(nvram get ntp_ready)" = 0 ]; then
	killall ntp >/dev/null 2>&1 &
	sleep 2
	ntp &
	sleep 2
	#tail /tmp/syslog.log > /tmp/tailntp.out
	if [ "$(nvram get ntp_ready)" = "1" ]; then
		echo $(date +%b\ %d\ %X) ntp sys-self update sucssesful! >> /tmp/syslog.log
		exit
	else
		echo $(date +%b\ %d\ %X) ntp sys-self update fail! >> /tmp/syslog.log
	fi
	killall ntp >/dev/null 2>&1 &
	sleep 2
	i=3   #循环尝试次数，时间列表内的全部试过一遍后会重复循环
	until [ "$(nvram get ntp_ready)" = "1" ] ; do
	i=$(($i-1))
		if [ "$i" = 0 ];then
			break
		fi
		for ntp_server in $ntp_server_list
		do
			if [ "$(nvram get ntp_ready)" = "0" ] ; then
				ntpclient -h $ntp_server -i 3 -l -s 2>/dev/null &
				ntp_server_last_tried=$ntp_server
				echo $(date +%b\ %d\ %X) waiting ntp update! server：$ntp_server  >> /tmp/syslog.log
				sleep 6  #不要设太小，容易引起判断错误，最小值设为4就够小了
			fi
		done
	done
	sleep 3
	[ "$(ps |grep -w "ntp"|grep -cv grep)" = "0" ] && nohup ntp >/dev/null 2>&1 &
	
	if [ "$(nvram get ntp_ready)" = "1" ]; then
		echo $(date +%b\ %d\ %X) ntp update sucssesful! >> /tmp/syslog.log
		#将成功更新的服务器设到默认的0号服务器上
		[ "$ntp_server_last_tried" != "" ] && {
			nvram set ntp_server0=$ntp_server_last_tried 
			nvram commit
		}
		echo $(date +%b\ %d\ %X) sucssesful reset ntp_server0:$(nvram get ntp_server0)! >> /tmp/syslog.log 
	else
		echo $(date +%b\ %d\ %X) ntp update fail,pls check NTP server! >> /tmp/syslog.log	
	fi
else
	echo $(date +%b\ %d\ %X) sys time already updated,exit! >> /tmp/syslog.log	
fi


	