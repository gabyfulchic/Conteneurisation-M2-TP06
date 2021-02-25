#!/bin/sh

set -x

# set perms for ssh
cp /tmp/ssh/id_rsa.pub /root/.ssh/authorized_keys
chown root:root /root/.ssh/authorized_keys
chmod 0600 /root/.ssh/authorized_keys

# some checks
cat /tmp/shared_folder/foo.txt
cat /root/.ssh/authorized_keys
ls -alFh /etc/ssh/ /etc/ssh/sshd_config /root /root/.ssh

# generate host keys and launch sshd
ssh-keygen -A
/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config
