#!/bin/sh
# These 3 variables must be modified according to user setup
# They are not subject to change (check SD root folder just in case)
# Default values according to course slides (1_nanopi.pdf)
SD_ROOT_FOLDER=/dev/sdb         # SD card root directory, unmounted
LOCAL_MNT_POINT=/run/media/lmi  #default SD card mount point
HOME_DIR=/home/lmi              # user home directory

SD_ROOT_PART1=${SD_ROOT_FOLDER}1
SD_ROOT_PART2=${SD_ROOT_FOLDER}2

umount $SD_ROOT_FOLDER
#initialize 480MiB to 0
sudo dd if=/dev/zero of=$SD_ROOT_FOLDER count=120000
sync

# First sector: msdos
sudo parted $SD_ROOT_FOLDER mklabel msdos

#copy sunxi-spl.bin binaries
sudo dd if=${HOME_DIR}/workspace/nano/buildroot/output/images/sunxi-spl.bin of=$SD_ROOT_FOLDER bs=512 seek=16

#copy u-boot
sudo dd if=${HOME_DIR}/workspace/nano/buildroot/output/images/u-boot.itb of=$SD_ROOT_FOLDER bs=512 seek=80


# 1st partition: 64MiB: (163840-32768)*512/1024 = 64MiB
sudo parted $SD_ROOT_FOLDER mkpart primary ext4 32768s 163839s

# 2nd partition: 1GiB: 4358144-163840)*512/1024 = 2GiB
sudo parted $SD_ROOT_FOLDER mkpart primary ext4 163840s 4358143s
sudo mkfs.ext4 $SD_ROOT_PART1 -L BOOT # Change line "-L" is for Volume Label
sudo mkfs.ext4 $SD_ROOT_PART2 -L rootfs
sync

#copy kernel, flattened device tree, boot.scr
sudo mount $SD_ROOT_PART1 $LOCAL_MNT_POINT
sudo cp ${HOME_DIR}/workspace/nano/buildroot/output/images/Image $LOCAL_MNT_POINT
sudo cp ${HOME_DIR}/workspace/nano/buildroot/output/images/nanopi-neo-plus2.dtb $LOCAL_MNT_POINT
sudo cp ${HOME_DIR}/workspace/nano/buildroot/output/images/boot.scr $LOCAL_MNT_POINT
sync

#Rename 1st partition to BOOT
#sudo umount $SD_ROOT_PART1
#sudo fatlabel $SD_ROOT_PART1 BOOT
#copy rootfs
sudo dd if=${HOME_DIR}/workspace/nano/buildroot/output/images/rootfs.ext4 of=$SD_ROOT_PART2
# Resize and rename 2nd partition to rootfs
# check if the partition must be mounted
sudo e2fsck -f $SD_ROOT_PART2
sudo resize2fs $SD_ROOT_PART2
sudo e2label $SD_ROOT_PART2 rootfs
