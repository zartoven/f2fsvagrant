#!/bin/bash
apt-get update
apt-get -y dist-upgrade
apt-get install -y git ncurses-dev libssl-dev
apt-get install -y build-essential build-dep linux libssl-dev ncurses-dev
apt-get install -y uuid-dev pkg-config autoconf libtool libselinux1-dev autopoint libtirpc-dev libwrap0-dev gettext

git clone git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
cd f2fs
git checkout dev-test
cp /vagrant/f2fs_config .config
make -j `nproc`
make modules_install
make install
