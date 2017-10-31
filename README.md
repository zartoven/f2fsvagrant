# f2fsvagrant: F2FS development environment with vagrant

Few scripts to automate f2fs development environment.

This scripts will do followings

* Create an Ubuntu 14.04 VM with 4 CPU and 8 MB memory.
* Download, compile, and install f2fs kernel (branch dev-test).
* Install virtualbox guest plugin for newly installed kernel.
* Setup following packages with sources:
  - quota-tools
  - f2fs-tools (g-dev-test branch)
  - xfsprog
  - xfstests-f2fs (f2fs branch)

32GB sized /dev/sdb will be there for testing, and two 16 GBsized partitions (sdb1, sdb2) will be created.

## Prerequisites

- Install VirtualBox 5.1: https://www.virtualbox.org/wiki/Download_Old_Builds_5_1
- Install latest Vagrant (2.0.0): https://www.vagrantup.com/downloads.html

## Additional Installation for Mac
Basically we need to install wget to download VirtualBox's latest guest plugin iso file.

- Install home brew: https://brew.sh/
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

- Install wget

```
brew install wget
```

## Usage

It will take about 1 hour to create a ready-to-develop VM environment.

```
./create.sh <VM home directory> <VM name> <VM ipaddress>
```

Example:

```
./create.sh .. vm1 10.0.0.10
```

After the command finishs, move to the VM home directory and try following command to connect to the created VM.

```
vagrant ssh
```

## Useful Tips

* User id and password are vagrant / vagrant
* The VM's home directory will be mounted to the VM /vagrant directory.
* Few useful vagrant commands
```
vagrant up       # Turn on VM
vagrant halt     # Turn off VM
vagrant destroy  # Destroy (delete) VM
```

* For more information about vagrant, visit https://www.vagrantup.com/docs/index.html
