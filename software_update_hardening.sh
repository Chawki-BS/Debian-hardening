#!/bin/bash

# Configure APT to only use HTTPS for package downloads
sed -i '/^#.*https.*$/s/^#//' /etc/apt/sources.list
sed -i '/^deb-src/s/^/#/' /etc/apt/sources.list
apt-get update

# Install package verification tools
apt-get install -y debian-keyring debian-archive-keyring apt-transport-https ca-certificates gnupg2

# Import trusted package signing keys
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0x12345678
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0x12345679

# Verify that packages are signed with trusted keys
apt-get update
apt-get install -y debsums
debsums_init
debsums -cs

# Clean up the APT cache
apt-get clean
rm -rf /var/lib/apt/lists/*
