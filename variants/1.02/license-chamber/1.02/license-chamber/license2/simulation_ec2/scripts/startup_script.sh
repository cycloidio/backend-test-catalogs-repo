#!/bin/bash

# stopping and disabling firewall
systemctl stop firewalld
systemctl disable firewalld


#Install OpenSWAN

yum install openswan -y

#Set sysctl params

echo 'net.ipv4.ip_forward = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0' | tee -a /etc/sysctl.conf

sysctl -p

service network restart