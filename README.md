# Ansible Docker Lab
A Docker Lab built for ansible testing of remote servers.  Related to ansible pluralsight course [Ansible Fundamentals - by Red Hat](https://app.pluralsight.com/library/courses/ansible-fundamentals/table-of-contents).

## Getting Started

Generate your ssh keys for root user. run in WSL bash or shell on OSX/linux

```shell
cd docker
set-ssh-key.sh
```

Run the following command to startup your servers.

```shell
docker-compose -f .\docker\docker-compose.yml up
```

In a separate terminal run this command that will get you into the control docker container to run your ansible commands.

``` shell
docker exec -it docker_control_1 bash
su demo
cd ~/ansible
ansible --version
```
