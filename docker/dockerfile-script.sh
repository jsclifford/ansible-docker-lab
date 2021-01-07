#/bin/bash

dnf update
dnf makecache
dnf -y install epel-release
dnf makecache
dnf -y install ansible sudo openssh-clients openssh-server systemd tree python3-pip 

groupadd -r demo &&  useradd -r -m -g demo demo

cat /tmp/creds.txt | grep demo | chpasswd
cat /tmp/creds.txt | grep root | chpasswd

usermod -aG wheel demo
echo "demo         ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers

ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''

rm -rf /run/nologin
mkdir /root/.ssh
chmod 700 /root/.ssh

mkdir -p /home/demo/.ssh 
chown -R demo:demo /home/demo
chmod 700 /home/demo/.ssh

# Setting up sftp user
useradd -s /sbin/nologin sftpuser
cat /tmp/creds.txt | grep sftpuser | chpasswd

mkdir -p /var/sftp/uploads
chown sftpuser:sftpuser /var/sftp/uploads

chown root:root /var/sftp
chmod 755 /var/sftp

rm /tmp/creds.txt

# Installing windows hosts modules for communicating to windows hosts with ansible.
pip3 install pywinrm
pip3 install pywinrm[credssp]
pip3 install awxkit
