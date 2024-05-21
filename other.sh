#!/usr/bin/expect



# 设置域名列表
set domain_list {github.com api.github.com}

# 遍历域名列表
foreach domain $domain_list {
    # 获取域名的 IP 地址列表
    set server_ip_list [exec nslookup $domain | grep "Address" | awk '{print $2}']

    # 遍历 IP 地址列表
    foreach server_ip $server_ip_list {
        # 设置命令
        set command "echo $server_ip $domain | sudo tee -a /etc/hosts"

        # 设置密码
        set password "wsbnd9"

        # 执行命令并自动输入密码
        spawn $command
        expect "password"
        send "$password\r"
        expect eof
    }
}
