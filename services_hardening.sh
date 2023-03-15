#!/bin/bash

# Disable unused services
systemctl disable avahi-daemon
systemctl disable cups
systemctl disable isc-dhcp-server
systemctl disable isc-dhcp-server6
systemctl disable slapd
systemctl disable nfs-kernel-server
systemctl disable rpcbind
systemctl disable vsftpd
systemctl disable dovecot
systemctl disable exim4
systemctl disable apache2
systemctl disable mysql

# Remove unneeded packages
apt-get purge -y avahi-daemon
apt-get purge -y cups
apt-get purge -y isc-dhcp-server
apt-get purge -y isc-dhcp-server6
apt-get purge -y slapd
apt-get purge -y nfs-kernel-server
apt-get purge -y rpcbind
apt-get purge -y vsftpd
apt-get purge -y dovecot
apt-get purge -y exim4
apt-get purge -y apache2
apt-get purge -y mysql-server

# Enable and configure firewall
apt-get install -y ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

# Limit network access for certain services
echo "sshd: 192.168.0.0/24" >> /etc/hosts.allow
echo "ALL: ALL" >> /etc/hosts.deny

# Configure SSH daemon
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
echo "AllowGroups sudo" >> /etc/ssh/sshd_config
echo "Protocol 2" >> /etc/ssh/sshd_config
echo "MaxAuthTries 3" >> /etc/ssh/sshd_config
echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config
echo "PermitUserEnvironment no" >> /etc/ssh/sshd_config
echo "ClientAliveInterval 300" >> /etc/ssh/sshd_config
echo "ClientAliveCountMax 0" >> /etc/ssh/sshd_config
systemctl restart ssh

# Configure PAM
sed -i 's/@include common-auth/#@include common-auth/' /etc/pam.d/su
echo "auth required pam_securetty.so" >> /etc/pam.d/su
echo "auth required pam_tally2.so deny=5 onerr=fail unlock_time=1800" >> /etc/pam.d/common-auth
echo "account required pam_tally2.so" >> /etc/pam.d/common-auth
