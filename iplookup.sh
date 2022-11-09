#!/usr/bin/env bash  


hosts=/etc/hosts

iplookup(){
    IP=$(dig +short $1 | head -n 1)
    echo ${IP}
}

domains_bak=(
    "github.githubassets.com"
    "central.github.com"
    "desktop.githubusercontent.com"
    "assets-cdn.github.com"
    "camo.githubusercontent.com"
    "github.map.fastly.net"
    "github.global.ssl.fastly.net"
    "gist.github.com"
    "github.io"
    "github.com"
    "api.github.com"
    "raw.githubusercontent.com"
    "user-images.githubusercontent.com"
    "favicons.githubusercontent.com"
    "avatars5.githubusercontent.com"
    "avatars4.githubusercontent.com"
    "avatars3.githubusercontent.com"
    "avatars2.githubusercontent.com"
    "avatars1.githubusercontent.com"
    "avatars0.githubusercontent.com"
    "avatars.githubusercontent.com"
    "codeload.github.com"
    "github-cloud.s3.amazonaws.com"
    "github-com.s3.amazonaws.com"
    "github-production-release-asset-2e65be.s3.amazonaws.com"
    "github-production-user-asset-6210df.s3.amazonaws.com"
    "github-production-repository-file-5c1aeb.s3.amazonaws.com"
    "githubstatus.com"
    "github.community"
    "media.githubusercontent.com"
)

domains=(
    "github.com"
    "github.global.ssl.fastly.net"
    "raw.githubusercontent.com"
)



printf "##########dig short domain start############\n"

IpAddress+="# MyAuto $(date)\n$(
    for domain in "${domains[@]}"; do
        {
            ipaddress=$(iplookup $domain)
            if [[ -n "$ipaddress" ]]; then
                printf "$ipaddress  $domain\n"
            else
                printf "# $domain not found!\n"
            fi
        } &
    done
    wait
)\n# MyAuto on $(date)\n"

printf "ok edit hosts ... \n"

if [ "$EUID" -ne 0 ]; then
    printf "error\nwill write\n$IpAddress\nPlease run as root"
else

   OS="`uname`"
   if [[ "$OS" == "darwin"* ]]; then
      sed -i '' -e '/^# MyAuto.*/,/&/d' $hosts
   else
     sed -i -e '/^# MyAuto.*/,/&/d' $hosts
   fi
    printf "$IpAddress" >>$hosts
    printf "ok\n"

    # 清除DNS缓存命令
    sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder;say flushed
fi









