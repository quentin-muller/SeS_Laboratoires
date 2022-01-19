## Laboratoire SSH 

## Partie 1 

- aller sur le site openssh.com
- download (openssh) et le .asc
-  taper sur la console `gpg --verify openssh-8.8p1.tar.gz.asc`
- taper `gpg --keyserver keyserver.ubuntu.com --search-keys 7168B983815A5EEF59A4ADFD2A3F414E736060BA` (validé avec '1')
- relancer `gpg --verify openssh-8.8p1.tar.gz.asc` et c'est bon

## Partie 2

- Taper `tar xvzf openssh-8.8p1.tar.gz`
- cd `openssh-8.8p1`
- `./configure --prefix=/home/lmi/SeS/Labo05_ssh/intel`
- make
- make install
- cd intel/bin
- file ssh -> pour vérifier le stripped

## Partie 3

- cd `openssh-8.8p1`
- `./configure --prefix=/home/lmi/SeS/Labo05_ssh/nanopi --host=aarch64-none-linux-gnu`
- dans le dossier `openssh-8.8p1` `sed -i 's/STRIP_OPT=-s/STRIP_OPT=-s --strip-program=aarch64-none-linux-gnu-strip/g' Makefile`
- make
- make install
- cd nanopi/bin
- file ssh -> pour vérifier le stripped

## Partie 4

lancer `./generate_sd_ext4.sh`

## Partie 5

1. Copier les 4 fichier sur /root/sshd -> moduli, ssh-keygen, sshd_config, sshd

2. Ajouter le fichier genKey.sh pour generer les clés

   Exemple

   1. ./ssh-keygen -t rsa -b 4096 -C "quentin.muller@bluewin.ch"
   2. ./ssh-keygen -t dsa -b 1024 -C "quentin.muller@bluewin.ch"

3. Sur la VM changer l'adresse ip source et la route avec les commandes ci-dessous

   ```bash
   sudo ifconfig ens160u1 192.168.0.1 netmask 255.255.255.0
   sudo ip route add 192.168.0.11 via 192.168.0.1
   ```

4. Ajouter un utilisateur sur le nanopi

   ```bash
   mkdir /home
   mkdir /home/sshd
   adduser sshd -h /home/sshd # ajouter une mot de passe 'ilovelmi'
   ```

5. Init de sshd

   ```bash
   /etc/init.d/S50dropbear stop #couper l'autre soft
   cd /root/sshd
   ./genKey.sh
   /root/sshd/sshd
   ```

6. Config de ssh

   1. Sur la nanopi aller copier le contenu de `cat ssh_host_ed25519_key.pub`
   2. Sur la VM collé le contenu dans `nano /home/lmi/.ssh/known_hosts`
   3. Sur la nanopi taper `mkdir /var/empty`

7. Se connecter depuis la VM sur la nanopi

   ```bash
   ssh sshd@192.168.0.11 # avec le mot de passe 'ilovelmi'
   ```

8. Prier

## Partie 6

Dans le fichier `sshd_config`

```bash
#AddressFamily any
AddressFamily inet

#AllowTcpForwarding yes
AllowTcpForwarding no

#PermitRootLogin prohibit-password
PermitRootLogin no

#Ajouter
Ciphers aes256-cbc,aes256-ctr,aes128-cbc,hmac-sha-256,hmac-sha1

#Banner none
Banner "Labo05 SSH Quentin et Tristan"
```