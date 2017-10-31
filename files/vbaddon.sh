#!/bin/bash

mount /dev/cdrom /mnt
cd /mnt
echo yes | ./VBoxLinuxAdditions.run 
cd -
umount /mnt
