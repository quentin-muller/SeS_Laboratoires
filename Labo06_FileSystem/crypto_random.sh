#!/bin/sh

DEVICE=/dev/sdb3

PATH_LOCAL=/home/lmi/VM_SeS/luks_header

echo "---------------------- Unmount device ------------------------------"

sudo umount $DEVICE

echo "-------------------------- Crypting partition --------------------------------------"

sudo cryptsetup --debug --pbkdf pbkdf2 luksFormat $DEVICE -q --key-file ${PATH_LOCAL}/rand_key.txt

echo "-------------------------- First Dump --------------------------------------"

sudo cryptsetup luksDump $DEVICE

echo "-------------------------- Add Key --------------------------------------"

sudo cryptsetup luksAddKey $DEVICE --key-file ${PATH_LOCAL}/rand_key.txt

echo "-------------------------- Second Dump --------------------------------------"

sudo cryptsetup luksDump $DEVICE

echo "-------------------------- Open --------------------------------------"

sudo cryptsetup --debug open --type luks $DEVICE usrfs1 --key-file ${PATH_LOCAL}/rand_key.txt

echo "---------------------- mkfs.ext4 LUKS ------------------------------"

sudo mkfs.ext4 /dev/mapper/usrfs1 -L LUKS

echo "---------------------- mount /dev/mapper/usrfs1 ------------------------------"

sudo mount /dev/mapper/usrfs1 /mnt/usrfs

echo "-------------------------- dd ---------------------------"

sudo dd if=$PATH_LOCAL/luks_file_2.txt of=/mnt/usrfs bs=4M count=1

echo "---------------------- Unmount device ------------------------------"

sudo umount /dev/mapper/usrfs1

echo "-------------------------- Close --------------------------------------"

sudo cryptsetup close usrfs1

echo "-------------------------- DONE ----------------------------"
