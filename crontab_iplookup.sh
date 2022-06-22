#!/bin/bash



DATE=`date +%Y%m%d%H%M%S`
echo -e "\033[33;40m  current github iplookup time: $DATE  \033[0m"
#调用交互式脚本
expect autosudo.sh > /tmp/xx_`date +%Y%m%d`
sleep 1

echo -e "\033[33;40m  ($0) ${TIME}: this shell script execution duration: ${SECONDS}s  \033[0m"
echo "😊😊😊😊😊😊success excute shell😊😊😊😊😊😊"