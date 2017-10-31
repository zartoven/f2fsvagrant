#!/bin/bash

# Install quota tools
git clone git://git.kernel.org/pub/scm/utils/quota/quota-tools.git
cd quota-tools
./autogen.sh
./configure
make
make install
cd ..

# Install f2fs-tools : g-dev-test branch
git clone https://github.com/jaegeuk/f2fs-tools
cd f2fs-tools
git checkout g-dev-test
./autogen.sh
./configure --prefix=/usr
make
make install
cd ..

# Install xfsprog
apt-get install -y libblkid-dev
git clone git://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git
cd xfsprogs-dev
make 
make install
make install-dev
cd ..

# Insall xfstests-f2fs
apt-get install -y attr-dev acl-dev libaio-dev
git clone https://github.com/jaegeuk/xfstests-f2fs
cd xfstests-f2fs
git checkout f2fs
make
cd ..

# Create partitions: sdb1 and sdb2
(echo n; echo p; echo 1; echo ; echo +16G; echo n; echo p; echo 2; echo ; echo; echo w) | fdisk /dev/sdb
mkdir -p /mnt/test
