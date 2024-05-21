#!/usr/bin/env bash  



#0 */1 * * *  cd /usr/local/Cellar/nginx/1.19.1/html/makeGithubFast  && echo wsbnd9 | sudo -S sh new.sh  >> /tmp/crontab_new.log

hosts=/etc/hosts




IpAddress=`curl https://hosts.gitcdn.top/hosts.txt`

printf "ok edit hosts ... \n"

printf "$IpAddress"

if [ "$EUID" -ne 0 ]; then
    printf "error\nwill write\n$IpAddress\nPlease run as root"
else

   OS="`uname`"
   if [[ "$OS" == "darwin"* ]]; then
      sed -i '' -e '/^# fetch-github-hosts.*/,/&/d' $hosts
   else
     sed -i -e '/^# fetch-github-hosts.*/,/&/d' $hosts
   fi
    printf "$IpAddress" >>$hosts
    printf "ok\n"

    # 清除DNS缓存命令
    sudo killall -HUP mDNSResponder ;say flushed
    printf "Reload OK!\n"
fi









