#!/bin/bash 

# sudo chmod +x  edit-host.sh
# chmod -R 777 edit-host.sh
# sudo ./edit-host.sh
# 测试 !/bin/bash -x
# 如果git push 提示没权限  解决：sudo chown -R "${USER:-$(id -un)}" . 

#Mac获取GitHub的IP 追加到hosts文件中

cd $(dirname $0)



echo ">>>begin remove host for github>>>"

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


echo ">>>done remove host for github>>>"


echo ">>>start getGithubIP >>>"

python3 getGithubIP.py

echo ">>>done getGithubIP>>>"




if [ ! -f ${filename} ];then
  echo ">>>文件不存在>>>"
else
	# sudo -s
	cat hosts >> /etc/hosts

fi


# 清除DNS缓存命令
sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say flushed


