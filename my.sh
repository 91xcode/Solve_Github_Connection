#autorm.sh#expect的安装路径
#/usr/bin/expect这个路径安装完expect之后 which expect可以查看
#!/usr/bin/expect -f

#设置超时时间 
set timeout 3
#设置你的Mac用户密码
set password wsbnd9
#传递交互指令
spawn sudo sh edit-host.sh
#根据输出传递数据,在这里是等待密码提示显示
expect "*asswor*" 
send "$password\r"
#保持在远端  
interact