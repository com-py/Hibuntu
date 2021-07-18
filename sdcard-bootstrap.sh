#!/bin/sh
set -x
DEV="/dev/mmcblk0"

umount ${DEV}*
fdisk ${DEV}
cgpt create ${DEV}
cgpt add -i 1 -t kernel -b 8192 -s 32768 -l Kernel -S 1 -T 5 -P 10 ${DEV}
cgpt show ${DEV}

rootfs_pos="`cgpt show ${DEV} | grep \"Sec GPT table\" | awk '{print $1}'`"
echo $rootfs_pos
cgpt add -i 2 -t data -b 40960 -s `expr ${rootfs_pos} - 40960` -l Root ${DEV}
partx -a ${DEV}
