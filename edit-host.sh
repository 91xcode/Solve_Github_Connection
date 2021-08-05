#!/bin/bash -x

# sudo chmod +x  edit-host.sh
# ./edit-host.sh

#Mac获取GitHub的IP 追加到hosts文件中

cd $(dirname $0)



echo ">>>begin>>>"

filepath="/etc/hosts"

filename="hosts"


start=$(egrep -n "GitHub520 Host Start" $filepath | awk -F ":" '{print $1}')

end=$(egrep -n "GitHub520 Host End" $filepath | awk -F ":" '{print $1}')


if [ ! $start ] && [ ! $end ]; then
  
echo ">>>no start and end empty >>>"
  
else
  
echo $start
echo $end

if [ ${start} -gt 0 ] && [ ${end} -gt 0 ]; then
	sed -i ""  "${start},${end}d" $filepath

else
	echo ">>>no start or end >>>"
fi
  
fi 


echo ">>>finish>>>"



python3 getGithubIP.py


if [ ! -f ${filename} ];then
  echo ">>>文件不存在>>>"
else
	sudo -s
	cat hosts >> /etc/hosts

fi


