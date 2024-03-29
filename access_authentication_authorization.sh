#!/bin/bash


# Set restrictive file permissions on sensitive files and directories
chmod 0600 /etc/shadow /etc/passwd /etc/group
chmod 0700 /root
chmod 0750 /etc/sudoers.d

# Enable sudo logging to track privileged access
echo "Defaults logfile=/var/log/sudo.log" > /etc/sudoers.d/logging
chmod 440 /etc/sudoers.d/logging

# Limit access to system files and directories
chmod 0750 /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin
chmod 0700 /etc /boot /root /home /var /usr/local/src
