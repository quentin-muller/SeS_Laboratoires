DEVICE = /dev/sdb3

sudo cryptsetup --debug open --type luks $DEVICE usrfs1

sudo mount /dev/mapper/usrfs1 /mnt/usrfs
