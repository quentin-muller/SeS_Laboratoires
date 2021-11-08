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

## Partie 5

1. ./ssh-keygen -t rsa -b 4096 -C "quentin.muller@bluewin.ch"
2. ./ssh-keygen -t dsa -b 1024 -C "quentin.muller@bluewin.ch"
3. 