#/bin/bash

ssh-keygen -t rsa -b 4096 -C "demo@local.net" -m PEM -N "" -f ~/.ssh/ansible-docker-lab -q
cp  ~/.ssh/ansible-docker-lab.pub ./config/volume-files/authorized_keys.pub
cp  ~/.ssh/ansible-docker-lab ./config/volume-files/private_keys/ansible-docker-lab

echo "Checking if keys exist."
ls -al ~/.ssh