#!/bin/sh
DEVICE=/dev/sdb3
PATH=/home/lmi/VM_SeS/luks_header

sudo umount $DEVICE

sudo cryptsetup --debug --pbkdf pbkdf2 luksFormat $DEVICE -q --key-size=512 --key-file=${PATH}/rand_key.txt

sudo cryptsetup luksDump $DEVICE

sudo cryptsetup --debug open --type luks $DEVICE usrfs1

sudo mkfs.ext4 /dev/mapper/usrfs1 -L LUKS

sudo mount /dev/mapper/usrfs1 /mnt/usrfs
