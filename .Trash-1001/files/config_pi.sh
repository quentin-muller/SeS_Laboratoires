#!/bin/sh
echo "--------------Create directory-----------------"
mkdir /home
mkdir /home/sshd
echo "-------------Create user ----------------------"
adduser sshd -h /home/sshd # ajouter une mot de passe 'ilovelmi'
echo "-------------Stop dropbear---------------------"
/etc/init.d/S50dropbear stop #couper l'autre soft
echo "-------------Create key------------------------"
cd /root/sshd
./genKey.sh
cat ssh_host_ed25519_key.pub

echo "------------Start ssh--------------------------"
mkdir /var/empty
/root/sshd/sshd

