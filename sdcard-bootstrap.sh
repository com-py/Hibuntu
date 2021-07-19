#!/bin/sh
#adapted from: https://archlinuxarm.org/platforms/armv7/rockchip/hisense-chromebook-c11 
#set -x
DEV="/dev/mmcblk0"
ROOTFS="/dev/mmcblk0p2"

chk="`cgpt show -i 10 ${DEV} | grep Unused`"
if [ "$chk" = "" ]; then
  echo -e "\nPartition table does not look correct - is this the internal eMMC? \n\a\a"
  exit
fi

umount ${DEV}*

fdisk ${DEV} <<EEOF
g
w

EEOF

cgpt create ${DEV}
cgpt add -i 1 -t kernel -b 8192 -s 32768 -l Kernel -S 1 -T 5 -P 10 ${DEV}
cgpt show ${DEV}

rootfs_pos="`cgpt show ${DEV} | grep \"Sec GPT table\" | awk '{print $1}'`"
echo $rootfs_pos
cgpt add -i 2 -t data -b 40960 -s `expr ${rootfs_pos} - 40960` -l Root ${DEV}
partx -a ${DEV}

mkfs.ext4 ${ROOTFS}
mkdir /tmp/mnt
mount ${ROOTFS} /tmp/mnt
debootstrap --arch=armhf --foreign bionic /tmp/mnt http://ports.ubuntu.com/ubuntu-ports
sync
umount ${ROOTFS}
