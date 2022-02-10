#!/bin/bash 

# sudo chmod +x  edit-host.sh
# chmod -R 777 edit-host.sh
# sudo ./edit-host.sh
# 测试 !/bin/bash -x
# 如果git push 提示没权限  解决：sudo chown -R "${USER:-$(id -un)}" . 

#Mac获取GitHub的IP 追加到hosts文件中

cd $(dirname $0)


LOG_OPEN=1

function log()
{
     [ $LOG_OPEN -eq 1 ]  && echo "$(date '+%Y-%m-%d %H:%M:%S') $@"
}

log '[*] begin ...'

filepath="/etc/hosts"

filename="hosts"


start=$(egrep -n "GitHub520 Host Start" $filepath | awk -F ":" '{print $1}')

end=$(egrep -n "GitHub520 Host End" $filepath | awk -F ":" '{print $1}')


if [ ! $start ] && [ ! $end ]; then
	log  "[*] no start and end empty..."
  
else
 
 	log  "[*] start:${start} and end :${end}..."

if [ ${start} -gt 0 ] && [ ${end} -gt 0 ]; then
	sed -i ""  "${start},${end}d" $filepath

else
		log  '[*] no start or end...'
fi
  
fi 

	log  '[√] remove host for github done...'


	log  '[*] python getGithubIP.py start...'

python3 getGithubIP.py


	log  '[√] python getGithubIP.py done...'


if [ ! -f ${filename} ];then
		log  '[√] 文件不存在...'
else
	# sudo -s
	cat hosts >> /etc/hosts
	log  '[√] add /etc/hosts done...'

fi


# 清除DNS缓存命令
sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say flushed


