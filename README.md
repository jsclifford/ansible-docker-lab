# Ansible Docker Lab
A Docker Lab built for ansible testing of remote servers.  Related to ansible pluralsight course [Ansible Fundamentals - by Red Hat](https://app.pluralsight.com/library/courses/ansible-fundamentals/table-of-contents) and [Managing Ansible with Red Hat Ansible Tower - by Red Hat](https://app.pluralsight.com/library/courses/red-hat-ansible-tower-managing/table-of-contents).

## Getting Started

Generate your ssh keys for root and demo user. Run in WSL bash or shell on OSX/linux

```shell
cd docker
set-ssh-key.sh
```

Run the following command to startup your servers.


```shell
# Run in root of the repo folder
docker-compose -f .\docker\docker-compose.yml up -d
```

Run this command that will get you into the control docker container to run your ansible commands.

``` shell
docker exec -it control bash
su demo
cd ~/ansible
ansible --version
# Notice the location of the config in the ansible version.
```

When training complete shutdown containers.

```shell
docker-compose -f .\docker\docker-compose.yml down
```

## Making Custom Docker image

To update the docker image with custom passwords you must follow below.

* Copy docker/config/creds-example.txt to docker/config/creds.txt
* Put passwords for every account after colins. ie. root:mypasswordhere
* CD to docker folder
* Run docker build or ```build-docker-image.ps1 -DockerHubRepo "yourrepohere"```

## Gotchas and Tips

* Tip: Copy ansible.cfg or all files in ansible/example-lab-files to the root of ansible folder to have a starting point and working configs.
* Gotcha: Cannot reboot servers due to being a container.
* Gotcha: Container /etc/hosts file is crucial to docker and is locked.  Any editing the file with ansible will result in an error.  [Stack Overflow of problem.](https://github.com/William-Yeh/docker-ansible/issues/4#issuecomment-149084120)  
