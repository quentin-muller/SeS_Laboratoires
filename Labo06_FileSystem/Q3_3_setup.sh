#!/bin/sh

DEVICE=/dev/sdb3
PATH_LOCAL=/home/lmi/SeS/Labo06_FileSystem/luks

sudo umount $DEVICE

sudo cryptsetup --debug --pbkdf pbkdf2 luksFormat $DEVICE -q --key-size 512 --key-file ${PATH_LOCAL}/random_key.txt

sudo cryptsetup luksDump $DEVICE

sudo cryptsetup --debug open --type luks $DEVICE usrfs1

sudo mkfs.ext4 /dev/mapper/usrfs1

sudo mount /dev/mapper/usrfs1 /mnt/usrfs
