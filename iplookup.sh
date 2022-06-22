#!/usr/bin/env bash
hosts=/etc/hosts

domains_bak=(
   "github.com"
   "github.global.ssl.fastly.net"
   "raw.githubusercontent.com"
)



domains=(
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
    "media.githubusercontent.com")
iplookup() {


	curl  'https://www.ipaddress.com/ip-lookup' \
  -H 'authority: www.ipaddress.com' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'accept-language: zh-CN,zh;q=0.9,en;q=0.8' \
  -H 'cache-control: max-age=0' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'cookie: ezosuigeneris-0=f6d0256c0401001abaffaa461042250a; ezosuibasgeneris-1=3d21bf95-caaa-4cc3-6b04-fbae47fe9ae5; ezds=ffid%3D1%2Cw%3D1440%2Ch%3D900; ezohw=w%3D1400%2Ch%3D796; ezux_ifep_280870=true; ezoref_280870=ipaddress.com; ezoab_280870=mod1; ezoadgid_280870=-1; ezovid_280870=924987977; lp_280870=https://www.ipaddress.com/; ezovuuid_280870=40b35260-c02e-4b99-6d41-1c1f29032a26; active_template::280870=pub_site.1653026158; ezopvc_280870=4; ezepvv=1493; ezovuuidtime_280870=1653026159; ezux_lpl_280870=1653026160498|4ba80d0c-67be-45be-5380-47b82b5ccd93|true; ezux_et_280870=23; ezux_tos_280870=253' \
  -H 'origin: https://www.ipaddress.com' \
  -H 'referer: https://www.ipaddress.com/ip-lookup' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="101", "Google Chrome";v="101"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36' \
  --data-raw "host=$1" \
  --compressed |
		perl -e 'while(<>){/https:\/\/www.ipaddress.com\/ipv4\/((\d+\.){3}\d+)/;if($1){print($1);last}}'
	# curl -sd "host=$1" https://www.ipaddress.com/ip-lookup |
		# perl -e 'while(<>){/https:\/\/www.ipaddress.com\/ipv4\/((\d+\.){3}\d+)/;if($1){print($1);last}}'
}

printf "lookup ipaddress from https://www.ipaddress.com/ip-lookup ..."

IpAddress+="# Auto Generate on $(date)\n$(
	for domain in "${domains[@]}"; do
		{
			ipaddress=$(iplookup $domain)
			if [[ -n "$ipaddress" ]]; then
				printf "$ipaddress	$domain\n"
			else
				printf "# $domain not found!\n"
			fi
		} &
	done
	wait
)\n# Auto Generate on $(date)\n"

printf "ok\nedit hosts ..."

if [ "$EUID" -ne 0 ]; then
	printf "error\nwill write\n$IpAddress\nPlease run as root"
else

   OS="`uname`"
   if [[ "$OS" == "darwin"* ]]; then
      sed -i '' -e '/^# Auto Generate.*/,/&/d' $hosts
   else
     sed -i -e '/^# Auto Generate.*/,/&/d' $hosts
   fi
	#sed -i "" '/^# Auto Generate.*/,/&/d' $hosts
	printf "$IpAddress" >>$hosts
	printf "ok\n"
fi
