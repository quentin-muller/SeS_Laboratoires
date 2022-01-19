#!/bin/sh
# These 3 variables must be modified according to user setup
# They are not subject to change(check SD root folder just in case)
# Default values according to course slides (1_NanoPi.pdf)
SD_ROOT_FOLDER=/dev/sdb         # SD card root directory, unmounted
LOCAL_MNT_POINT=/run/media/lmi  #default SD card mount point
HOME_DIR=/home/lmi              # user home directory
DEVICE=/dev/sdb3
PATH_Luks=/home/lmi/SeS/Labo06_FileSystem/luks

SD_ROOT_PART1=${SD_ROOT_FOLDER}1
SD_ROOT_PART2=${SD_ROOT_FOLDER}2
SD_ROOT_PART3=${SD_ROOT_FOLDER}3
#SD_ROOT_PART4=${SD_ROOT_FOLDER}4
echo "-------------------- #umount --------------------------"
umount $SD_ROOT_PART1
umount $SD_ROOT_PART2
umount $SD_ROOT_PART3
#umount $SD_ROOT_PART4
echo "-------------------- #initialize 480MiB to 0-----------"
#initialize 480MiB to 0
sudo dd if=/dev/zero of=$SD_ROOT_FOLDER count=120000
sync
echo "-------------------- # First sector: msdos-------------"
# First sector: msdos
sudo parted $SD_ROOT_FOLDER mklabel msdos
echo "-------------------- #copy sunxi-spl.bin binaries------"
#copy sunxi-spl.bin binaries
sudo dd if=${HOME_DIR}/workspace/nano/buildroot/output/images/sunxi-spl.bin of=$SD_ROOT_FOLDER bs=512 seek=16
echo "-------------------- #copy u-boot----------------------"
#copy u-boot
sudo dd if=${HOME_DIR}/workspace/nano/buildroot/output/images/u-boot.itb of=$SD_ROOT_FOLDER bs=512 seek=80
echo "-------------------- # 1st partition: 64MiB------------"
# 1st partition: 64MiB: (163840-32768)*512/1024 = 64MiB
sudo parted $SD_ROOT_FOLDER mkpart primary ext4 32768s 163839s
echo "-------------------- # 2nd partition: 1GiB-------------"
# 2nd partition: 1GiB: (4358144-163840)*512/1024 = 2GiB
sudo parted $SD_ROOT_FOLDER mkpart primary ext4 163840s 4358143s
sudo mkfs.ext4 $SD_ROOT_PART2 -L rootfs
sudo mkfs.ext4 $SD_ROOT_PART1 -L BOOT # Change line "-L" is for Volume Label
sync
echo "-------------------- # 3rd partition: 2GiB--------------"
# 3rd partition: 2GiB: (9338879-5242880)*512/1024 = 2GiB
sudo parted $SD_ROOT_FOLDER mkpart primary ext4 5242880s 9338879s
sudo mkfs.ext4 $SD_ROOT_PART3 -L LUKS
echo "----- #copy kernel, flattened device tree, boot.scr-----"
#copy kernel, flattened device tree, boot.scr
sudo mount $SD_ROOT_PART1 $LOCAL_MNT_POINT
sudo cp ${HOME_DIR}/workspace/nano/buildroot/output/images/Image $LOCAL_MNT_POINT
sudo cp ${HOME_DIR}/workspace/nano/buildroot/output/images/nanopi-neo-plus2.dtb $LOCAL_MNT_POINT
sudo cp ${HOME_DIR}/workspace/nano/buildroot/output/images/boot.scr $LOCAL_MNT_POINT
sudo cp ${HOME_DIR}/Output/uInitrd $LOCAL_MNT_POINT
sync
echo "-------------- #Rename 1st partition to BOOT -----------"
#Rename 1st partition to BOOT
sudo umount $SD_ROOT_PART1
sudo e2label $SD_ROOT_PART1 BOOT
echo "-------------------- #copy rootfs ----------------------"
#copy rootfs
sudo dd if=${HOME_DIR}/workspace/nano/buildroot/output/images/rootfs.ext4 of=$SD_ROOT_PART2
echo "---- #Resize and rename 2nd partition to rootf ---------"
# Resize and rename 2nd partition to rootfs
# check if the partition must be mounted
sudo e2fsck -f $SD_ROOT_PART2
sudo resize2fs $SD_ROOT_PART2
sudo e2label $SD_ROOT_PART2 rootfs

echo "---------- Unmount device -----------------------------"
sudo umount $DEVICE
echo "------------- Crypting partition ----------------------"
sudo cryptsetup --debug --pbkdf pbkdf2 luksFormat $DEVICE -q --key-file ${PATH_Luks}/rand_key.txt
echo "------------ First Dump -------------------------------"
sudo cryptsetup luksDump $DEVICE
#echo "-------------- Add Key --------------------------------"
#sudo cryptsetup luksAddKey $DEVICE --key-file ${PATH_Luks}/rand_key.txt
#echo "------------------ Second Dump ------------------------"
#sudo cryptsetup luksDump $DEVICE
echo "-------------------------- Open -----------------------"
sudo cryptsetup --debug open --type luks $DEVICE usrfs1 --key-file ${PATH_Luks}/rand_key.txt
echo "---------------------- mkfs.ext4 LUKS -----------------"
sudo mkfs.ext4 /dev/mapper/usrfs1 -L LUKS
echo "----------------- mount /dev/mapper/usrfs1 ------------"
sudo mount /dev/mapper/usrfs1 /mnt/usrfs
echo "-------------------------- dd -------------------------"
sudo dd if=/home/lmi/workspace/nano/buildroot/output/images/rootfs.ext4 of=/dev/mapper/usrfs1 bs=4M
echo "------------------ Unmount device ---------------------"
sudo umount /dev/mapper/usrfs1
echo "-------------------- Close ----------------------------"
sudo cryptsetup close usrfs1
echo "---------------------- DONE ---------------------------"