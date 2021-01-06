# Running Ansible against windows hosts

Setup windows servers for ansible.

## Setup Windows Hosts

Run commands on host:

```powershell
# In Admin Powershell window.
# Get WinRM config - check to see if CredSSP is enabled.
# Can be done with Group Policy
winrm get winrm/config/Service

# Command to download ansible configuration script for CredSSP.
wget https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1 -OutFile ConfigureRemotingForAnsible.ps1

# enable CredSSP for WinRM
.\ConfigureRemotingForAnsible.ps1 -EnableCredSSP -DisableBasicAuth -$ForceNewSSLCert -Verbose

# Verify CredSSP is working
winrm get winrm/config/Service

# Check for listener
winrm enumerate winrm/config/Listener

# Disable HTTP listener
Get-ChildItem -Path WSMan:\localhost\Listener | Where-Object { $_.Keys -eq "Transport=HTTP" } | Remove-Item -Recurse -Force

# Check for listener
winrm enumerate winrm/config/Listener

# Restart winrm
restart-service winrm

# Grant admin access to ansible service account.
```

## Setup Anisble on WSL

Two options to install.  With apt-get or pip3

```bash
# Install Ansible with apt-get on python2
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get install ansible python-pip # Uses python2 
pip install pywinrm
pip install pywinrm[credssp]


# Or with pip and python3
sudo apt-get update
sudo apt-get install python3-pip
pip3 install ansible
pip3 install pywinrm
pip3 install pywinrm[credssp]

# Tell Ansible to use the ansible.config in the current folder.
export ANSIBLE_CONFIG=./ansible.cfg

# Install ansible.windows modules
ansible-galaxy collection install ansible.windows

```