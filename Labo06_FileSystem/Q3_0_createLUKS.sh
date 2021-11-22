#!/bin/sh

DEVICE=/dev/sdb3

sudo cryptsetup --debug --pbkdf pbkdf2 luksFormat $DEVICE -q

sudo cryptsetup luksDump $DEVICE

sudo cryptsetup --debug open --type luks $DEVICE usrfs1 #--key-file ilovelmi

sudo mkfs.ext4 /dev/mapper/usrfs1

sudo mount /dev/mapper/usrfs1 /mnt/usrfs
