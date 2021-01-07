#!/bin/bash
SCRIPT_NAME=$(basename -- "$0")

set -e
theHostname=`hostname`
if [ "$theHostname" == 'control' ]
then
    if [[ -e "/root/files/private_keys/ansible-docker-lab" ]]; then
        cp /root/files/private_keys/ansible-docker-lab /root/.ssh/id_rsa
        chmod 600 /root/.ssh/id_rsa
    fi
    
    if [[ -e "/root/files/private_keys/ansible-docker-lab" ]]; then
        cp /root/files/private_keys/ansible-docker-lab /home/demo/.ssh/id_rsa
        chown demo:demo /home/demo/.ssh/id_rsa
        chmod 600 /home/demo/.ssh/id_rsa
    fi
else
    if [[ -e "/root/files/authorized_keys.pub" ]]; then
        cp /root/files/authorized_keys.pub /root/.ssh/authorized_keys
        chmod 600 /root/.ssh/authorized_keys
    
        cp /root/files/authorized_keys.pub /home/demo/.ssh/authorized_keys
        chown demo:demo /home/demo/.ssh/authorized_keys
        chmod 600 /home/demo/.ssh/authorized_keys
    fi
fi

rm -rf /run/nologin

/usr/sbin/sshd -D