#!/usr/bin/env bash
hosts=/tmp

domains=(
   "github.com"
   "github.global.ssl.fastly.net"
    "raw.githubusercontent.com"
)

iplookup() {
	curl -sd "host=$1" https://www.ipaddress.com/ip-lookup |
		perl -e 'while(<>){/https:\/\/www.ipaddress.com\/ipv4\/((\d+\.){3}\d+)/;if($1){print($1);last}}'
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
	sed -i '/^# Auto Generate.*/,/&/d' $hosts
	printf "$IpAddress" >>$hosts
	printf "ok\n"
fi
