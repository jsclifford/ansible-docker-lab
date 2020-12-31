#!/bin/bash

set -e

if [ "$1" = 'control' ]
then
    cp /root/files/private_keys/ansible-docker-lab /root/.ssh/id_rsa
    chmod 600 /root/.ssh/id_rsa
else
    cp /root/files/authorized_keys.pub /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
fi

exec /usr/sbin/sshd -D