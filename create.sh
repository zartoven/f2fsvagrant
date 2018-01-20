# !/bin/bash

VBGUEST=`vagrant plugin list | grep vbguest`

if [[ $VBGUEST"X" == "X" ]]; then
	vagrant plugin install vagrant-vbguest
fi

VBOX_ADDON_FILE=VBoxGuestAdditions_5.2.7-120326.iso

if [ ! -e $VBOX_ADDON_FILE ]; then
  wget https://www.virtualbox.org/download/testcase/$VBOX_ADDON_FILE
fi

if [ $# -ne 3 ]; then
	echo "# Usage <target directory> <vm_name> <ip_address>"
	exit 1
fi

if [ "$(uname)" == "Darwin" ]; then
MYSED="sed -i '' -e "
else
MYSED="sed -i "
fi

HOMEDIR=`pwd`
cd $1;
TARGET_PARENT=`pwd`
cd $HOMEDIR

NAME=$2
IPADDR=$3
TARGET=$TARGET_PARENT/$2
DVD_PATH=$HOMEDIR/$VBOX_ADDON_FILE

if [ -e $TARGET ]; then
	echo "ERROR: $TARGET already exist."
	exit -1
fi

echo "Step 1. Creating target directory"
mkdir -p $TARGET
cp -f files/* $TARGET/
cd $TARGET

echo "Step 2. Initialize vagrant."
vagrant init

echo "Step 3. Configure vagrant script."
cp $HOMEDIR/Vagrantfile .
$MYSED "s|VM_NAME|$NAME|g" Vagrantfile
$MYSED "s|VM_IP|$IPADDR|g" Vagrantfile
$MYSED "s|DVD_PATH|$DVD_PATH|g" Vagrantfile
$MYSED "s|TARGET|$TARGET|g" Vagrantfile

# Linux kernel compile
vagrant up
vagrant halt

# Install vbaddon
vagrant up
vagrant halt
rm $TARGET/vbaddon.sh

# Normal boot
vagrant up
