#!/bin/bash

# Set permissions on sensitive files and directories
chmod 700 /root
chmod 700 /home
chmod 700 /var/log
chmod 700 /etc/ssh

# Enable SELinux
apt-get install -y selinux-basics selinux-policy-default auditd
selinux-activate

# Set SELinux mode to enforcing
sed -i 's/SELINUX=disabled/SELINUX=enforcing/g' /etc/selinux/config

# Disable setuid and setgid permissions on binaries
find / -type f -perm /6000 -exec chmod a-s {} \;

# Configure auditd to monitor file system changes
echo "-w /etc/passwd -p wa -k passwd" >> /etc/audit/rules.d/audit.rules
echo "-w /etc/group -p wa -k group" >> /etc/audit/rules.d/audit.rules
echo "-w /etc/shadow -p wa -k shadow" >> /etc/audit/rules.d/audit.rules
echo "-w /etc/gshadow -p wa -k gshadow" >> /etc/audit/rules.d/audit.rules
echo "-w /var/log/faillog -p wa -k logins" >> /etc/audit/rules.d/audit.rules
echo "-w /var/log/lastlog -p wa -k logins" >> /etc/audit/rules.d/audit.rules
echo "-w /var/log/btmp -p wa -k logins" >> /etc/audit/rules.d/audit.rules
echo "-a exit,always -F arch=b64 -S chmod -S fchmod -
