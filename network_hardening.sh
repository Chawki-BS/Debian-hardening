#!/bin/bash

# Disable IPv6
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p

# Disable unused network protocols
echo "blacklist dccp" >> /etc/modprobe.d/blacklist.conf
echo "blacklist sctp" >> /etc/modprobe.d/blacklist.conf
echo "blacklist rds" >> /etc/modprobe.d/blacklist.conf
echo "blacklist tipc" >> /etc/modprobe.d/blacklist.conf

# Disable IP forwarding
echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.forwarding = 0" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.forwarding = 0" >> /etc/sysctl.conf
sysctl -p

