#!/bin/sh

ROOTFSLOC=ramfs
HOME=/home/lmi
echo "-------------------------- Begin --------------------------------------"
cd $HOME
mkdir Output
mkdir $ROOTFSLOC
mkdir -p $ROOTFSLOC/{bin,dev,etc,home,lib,lib64,usr,newroot,proc,root,sbin,sys}
mkdir $ROOTFSLOC/usr/lib64

echo "-------------------------- Cpy /dev -----------------------------------"
cd $ROOTFSLOC/dev
sudo mknod null c 1 3
#sudo mknod tty c 5 0
sudo mknod console c 5 1
sudo mknod random c 1 8
sudo mknod urandom c 1 9
sudo mknod mmcblk0p b 179 0
sudo mknod mmcblk0p1 b 179 1
sudo mknod mmcblk0p2 b 179 2
sudo mknod mmcblk0p3 b 179 3
sudo mknod mmcblk0p4 b 179 4
sudo mknod ttyS0 c 4 64
sudo mknod ttyS1 c 4 65
sudo mknod ttyS2 c 4 66
sudo mknod ttyS3 c 4 67

echo "-------------------------- Cpy /bin -----------------------------------"
cd ../bin
cp ~/workspace/nano/buildroot/output/target/bin/busybox .
ln -s busybox ls
ln -s busybox mkdir
ln -s busybox ln
ln -s busybox mknod
ln -s busybox mount
ln -s busybox umount
ln -s busybox sh
ln -s busybox sleep
ln -s busybox dmesg
ln -s busybox cryptsetup
cp ~/workspace/nano/buildroot/output/target/usr/bin/strace .

echo "-------------------------- Cpy /sbin -----------------------------------"
cd ../sbin
ln -s ../bin/busybox switch_root

echo "-------------------------- Cpy /lib64 ----------------------------------"
cd ../lib64
cp ~/workspace/nano/buildroot/output/target/lib64/ld-2.31.so .
cp ~/workspace/nano/buildroot/output/target/lib64/libresolv-2.31.so .
cp ~/workspace/nano/buildroot/output/target/lib64/libc-2.31.so .
ln -s libresolv-2.31.so libresolv.so.2
ln -s libc-2.31.so libc.so.6
ln -s ../lib64/ld-2.31.so ld-linux-aarch64.so.1

# Ajout depuis ~/target/lib64
cp ~/workspace/nano/buildroot/output/target/lib64/libm-2.31.so .
cp ~/workspace/nano/buildroot/output/target/lib64/librt-2.31.so .
cp ~/workspace/nano/buildroot/output/target/lib64/libdl-2.31.so .
cp ~/workspace/nano/buildroot/output/target/lib64/libpthread-2.31.so .
cp ~/workspace/nano/buildroot/output/target/lib64/libatomic.so.1.2.0 .
cp ~/workspace/nano/buildroot/output/target/lib64/libuuid.so.1.3.0 .
cp ~/workspace/nano/buildroot/output/target/lib64/libblkid.so.1.1.0 .

ln -s ../lib64/libm-2.31.so libm.so.6
ln -s ../lib64/librt-2.31.so librt.so.1
ln -s ../lib64/libdl-2.31.so libdl.so.2 
ln -s ../lib64/libpthread-2.31.so libpthread.so.0
ln -s ../lib64/libatomic.so.1.2.0 libatomic.so.1
ln -s ../lib64/libuuid.so.1.3.0 libuuid.so.1
ln -s ../lib64/libblkid.so.1.1.0 libblkid.so.1

echo "----------------------- Cpy /usr/lib64---------------------------------"
cd ../usr/lib64

cp ~/workspace/nano/buildroot/output/target/usr/lib64/libjson-c.so.5.1.0 .
cp ~/workspace/nano/buildroot/output/target/usr/lib64/libcrypto.so.1.1 .
cp ~/workspace/nano/buildroot/output/target/usr/lib64/libssl.so.1.1 .
cp ~/workspace/nano/buildroot/output/target/usr/lib64/libargon2.so.1 .
cp ~/workspace/nano/buildroot/output/target/usr/lib64/libdevmapper.so.1.02 .
cp ~/workspace/nano/buildroot/output/target/usr/lib64/libpopt.so.0.0.1 .
cp ~/workspace/nano/buildroot/output/target/usr/lib64/libcryptsetup.so.12.6.0 .


ln -s ../usr/lib64/libjson-c.so.5.1.0 libjson-c.so.5
ln -s ../usr/lib64/libcrypto.so.1.1 libcrypto.so
ln -s ../usr/lib64/libssl.so.1.1 libssl.so
ln -s ../usr/lib64/libargon2.so.1 libargon2.so
ln -s ../usr/lib64/libdevmapper.so.1.02 libdevmapper.so
ln -s ../usr/lib64/libpopt.so.0.0.1 libpopt.so.0
ln -s ../usr/lib64/libcryptsetup.so.12.6.0 libcryptsetup.so.12

echo "-------------------------- Cpy /lib -----------------------------------"
cd ../lib
cp ~/workspace/nano/buildroot/output/target/lib64/ld-2.31.so .
ln -s ../lib64/ld-2.31.so ld-linux-aarch64.so.1

echo "------------------------ Create /init ----------------------------------"
cd ..
cat > init << endofinput
#!/bin/busybox sh
mount -t proc none /proc
mount -t sysfs none /sys

mount -t ext4 /dev/mmcblk0p2 /newroot
mount -n -t devtmpfs devtmpfs /newroot/dev

exec sh
#exec switch_root /newroot /sbin/init
endofinput
######
chmod 755 init
cd ..
sudo chown -R 0:0 $ROOTFSLOC

echo "--------------------- cpio / gzip / mkimage ----------------------------"
cd $ROOTFSLOC
find . | cpio --quiet -o -H newc > ../Output/Initrd
cd ../Output
gzip -9 -c Initrd > Initrd.gz
mkimage -A arm -T ramdisk -C none -d Initrd.gz uInitrd

echo "----------------------------- DONE -------------------------------------"
