# 生成记录
## Jo本放在哪
### 客户端
`任意目录，比如/root`
- iperf_client.sh
### 服务端
`任意目录，比如/root`
- iperf_server.sh
- kill_shell.sh  
## Jo本怎么用
### 客户端
#### 添加计划任务
`vi etc/crontab`  
:bangbang:PATH末尾增加路径:bangbang:  
***PATH=:/usr/local/bin***
``` shell
#每小时第2分钟执行以下脚本
02 * * * * root /bin/bash /root/iperf_client.sh
```  
### 服务端
#### 添加计划任务
`vi etc/crontab`  
:bangbang:PATH末尾增加路径:bangbang:  
***PATH=:/usr/local/bin***
``` shell
#每小时第0分钟执行以下脚本
00 * * * * root /bin/bash /root/kill_shell.sh
#每小时第1分钟执行以下脚本
01 * * * * root /bin/bash /root/iperf_server.sh
```  
# 提取记录并生成结果
## Jo本放在哪
- result.sh  
由于服务端会显示丢包情况，所以一般在服务端运行  
:bangbang:注意：必须把脚本放在保存记录的文件夹内:bangbang:  
比如：`/root/iperf_history`
