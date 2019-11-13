#! /bin/bash
#遍历脚本所在目录内所有txt文件，并存在folder_list[]数据内
j=0
for i in `ls *txt* -1`
do
    folder_list[j]=$i
    j=`expr $j + 1`
done
#将数组遍历，取出数组内每一个txt
for(( i=0;i<${#folder_list[@]};i++))
 do
   #echo ${folder_list[i]};
#将txt的文件名、txt中第67行第6个字段、txt中第67行第6个字段取出并存进result.csv中
   echo "$(awk -F '  ' 'NR==67{print FILENAME,","$6,","$7}' ${folder_list[i]})" >> result.csv
#每遍历完24个txt后，增加空行
   if [ $(((($i+1))%24)) = '0' ]
   then
     echo -e "\n" >> result.csv
   fi       
done
