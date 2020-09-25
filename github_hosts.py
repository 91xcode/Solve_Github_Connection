#!/usr/bin/env python
# -*- coding: utf-8 -*-

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from lxml import etree
import time
import csv




Api="https://site.ip138.com/{}"

def configure_driver():
    opts = Options()
    opts.add_argument('--headless')
    prefs = {"profile.managed_default_content_settings.images": 2}
    opts.add_experimental_option("prefs", prefs)
    opts.add_argument('--user-agent=Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36')
    path = '/Users/liubing/Downloads/chromedriver'
    driver = webdriver.Chrome(executable_path=path, options=opts)
    return driver


def get_ip(host):
    """
    Get ip of host.
    """
    try:
        url = Api.format(host)
        # url = 'https://site.ip138.com/avatars2.githubusercontent.com/'
        browser = configure_driver()
        browser.get(url)
        time.sleep(.5)
        # print(browser.page_source)

        tree = etree.HTML(browser.page_source)
        res = tree.xpath('//div[@id = "curadress"]')
        host_ip=""
        for re in res:
            host_ip = re.xpath('.//p/a/text()')[0]
            # localtion = re.xpath('.//p/span/text()')[0]
            if not host_ip:
                break
        return host_ip
    except:
        print("Unable to get IP of Hostname")
        return ""

def main():
    f = open('github_hosts_connection.txt','w')
    f.write("# GitHub Start\n")
    f.close()

    with open("github_domain.txt", "r") as ins:
        for host in ins:
            ip=get_ip(host.strip())
            if not ip:
                continue
            with open('github_hosts_connection.txt', 'a') as result:
                result.write(ip.strip('\n') + " " + host)

    f = open('github_hosts_connection.txt','a')
    f.write("\n # GitHub End \n")
    f.close()

if __name__ == '__main__':

    main()

