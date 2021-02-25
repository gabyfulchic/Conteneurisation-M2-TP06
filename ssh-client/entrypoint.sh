#!/bin/sh

set -x
file_path="/foo.txt"

# set rsa-key pair to use for the ssh connection
cp /tmp/ssh/id_rsa.pub /root/.ssh/id_rsa.pub
cp /tmp/ssh/id_rsa /root/.ssh/id_rsa
chown root:root -R /root/.ssh/
chmod 0600 /root/.ssh/id_rsa
chmod 0644 /root/.ssh/id_rsa.pub

# some permissions checks
ls -alFh /tmp/ssh /root /root/.ssh/

# wait until sshd well started on the other container.
sleep 5

# enter in the rsync loop to get the file and verify ssh connectivity.
while true
do
	ssh -vvv root@ssh-server exit
	if [ $? -eq 0 ]; then
		rsync -v root@ssh-server:/tmp/shared_folder/foo.txt $file_path
		if [ $? -eq 0 ]; then
			cat $file_path
			echo "SUCCESS - we have well copied the file from the ssh-server by using rsync over ssh !"
			exit 0
		else
			sleep 1
			continue
		fi
	else
		echo "ERROR - SSH is bad configured, check authorized_keys, permissions & configurations."
		exit 1
	fi
done
