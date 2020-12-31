#!/bin/bash

set -e

if [ "$1" = 'control' ]
then
    cp /root/files/private_keys/ansible-docker-lab /root/.ssh/id_rsa
    chmod 600 /root/.ssh/id_rsa
    
    cp /root/files/private_keys/ansible-docker-lab /home/demo/.ssh/id_rsa
    chown demo:demo /home/demo/.ssh/id_rsa
    chmod 600 /home/demo/.ssh/id_rsa
else
    cp /root/files/authorized_keys.pub /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    
    cp /root/files/authorized_keys.pub /home/demo/.ssh/authorized_keys
    chown demo:demo /home/demo/.ssh/authorized_keys
    chmod 600 /home/demo/.ssh/authorized_keys
    
fi

exec /usr/sbin/sshd -D