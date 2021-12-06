# Laboratoire 6 sur les différents Files System

## Préambule

## Question 1 sur le nanopi

### 1. How kernel knows that rootfs is in the second partititon of the SDcard

Sur le PC aller dans le dossier `cd workspace/nano/buildroot/output/images/`

Puis taper la commande `cat boot.scr`

La root est décrite sur la première ligne root=xxxx

![image-20211115132722389](C:\Users\quent\AppData\Roaming\Typora\typora-user-images\image-20211115132722389.png)

### 2. mount the first partition

taper mount sur la nanopi avec minicom

### 3. what are the major and minor

taper `ls /dev/root -al` pour savoir sur quelle stockage c'est fixé

taper `ls -al /dev/mmc*` regarder le résultat

celui a regarder est le mmcblk0 -> 179, 0

## Question 2 filesystem

### 1. Create 2 new partitions (p3, p4)

with fdisk

`sudo fdisk /dev/sdb`  puis n et p puis 3 -> 5'242'880

La fin de la partition 2 est à 4'358'143 donc on peut utiliser la mémoire a partir de 4'358'144 le multiple rond de 1'048'576 est 5 fois soit 5'242'880

le prochain multiple de 2^20 est 5'242'880

taille de la partition est de 400MB soit 2048s*400 plus loins

soit 5'242'880 + 819'200 -1  = 6'062'079 **Attention au nb de secteur +1**

#### Partition 4

start
$$
6062080 / 2^{20} = x = \\
ceil(x) \cdot 2^{20} = 6291456
$$
stop
$$
6291456 + 400\cdot 2048s - 1 = 7110655
$$

### 2. choix des FS

1. btrfs

   1. installer les outils slide 17 `sudo dnf install xxxxxx`
   2. formater la partition en btrfs avec `sudo mkfs.btrfs /dev/sdb3 -L btrfs`

2. f2fs

   1. installer les outils slide 19 `sudo dnf install xxxxxx`
   2. formater la partition en f2fs avec `sudo mkfs.f2fs /dev/sdb4 -L f2fs`

   sudo cp /home/lmi/SeS/Labo06_FileSystem/compileFile /run/media/lmi/btrfs/
   sudo cp /home/lmi/SeS/Labo06_FileSystem/compileFile /run/media/lmi/f2fs/

   sur la nanopi :

   créer un dossier avec `mkdir /mnt/btrfs`

   monter la partition dans ce dossier `mount /dev/mmcblk0p3 /mnt/btrfs`

   aller dans le dossier `cd /mnt/btrfs`

   lancer le fichier cross complié `./compileFile`

## Question 3

### Partie 1 LUKS

   on a modifier le fichier generate.sh pour y ajouter une troisième partition.

   ```bash
   sudo parted $SD_ROOT_FOLDER mkpart primary ext4 5242880s 9338879s
   sudo mkfs.ext4 $SD_ROOT_PART3 -L LUKS
   ```

### Partie 2

#### 3.2.1 init

   ```bash
   #!/bin/sh
   DEVICE=/dev/sdb3
   sudo cryptsetup --debug --pbkdf pbkdf2 luksFormat $DEVICE -q
   sudo cryptsetup luksDump $DEVICE
   sudo cryptsetup --debug open --type luks $DEVICE usrfs1 #--key-file ilovelmi
   sudo mkfs.ext4 /dev/mapper/usrfs1
   sudo mount /dev/mapper/usrfs1 /mnt/usrfs
   ```

#### 3.2.2 copy

   ```bash
   sudo cp $LOCAL_PATH/copie_text.txt /mnt/usrfs
   ```

#### 3.2.3 add new passphrase

   ```bash
   DEVICE=/dev/sdb3
   sudo umount $DEVICE
   sudo cryptsetup luksAddKey $DEVICE
   ... 'iloveses'
   ```

#### 3.2.4 dump header

   ```bash
   sudo cryptsetup luksDump $DEVICE
   ```

#### 3.2.5 dd command

   ```bash
   sudo dd if=/dev/sdb3 of=${PATH_LOCAL}/file.txt bs=1M count=1
   ```

#### 3.2.5 Find header and 2 master key

##### header

   sur la première ligne avc ctrl f sur key (c'est un dictionnaire d'informations)

##### master key

   avec ghex dump on peut trouver la l'adresse aera offset le début de la master key et 512bits plus tard la fin ce qui nous donne la master key cryptée

#### 3.2.6 connect to the nanopi

   dans minicom faire boot le nanopi

   lancer la commande `cryptsetup --debug open --type luks $DEVICE usrfs1` avec le passphrase 'ilovelmi'

lancer `mkdir /mnt/usrfs`

lancer `mount /dev/mapper/usrfs1 /mnt/usrfs`

## Question 3.3

### 3.3.1 generate random passphrase

```bash
sudo dd if=/dev/urandom of=${PATH_LOCAL}/rand_key.txt bs=64 count=1
```

### 3.3.2 init luks with keyfile

fichier crypto_setup

### 3.3.5 cpy rootfs to luks

```bash
sudo dd if=~/workspace/nano/buildroot/output/images/rootfs.ext4 of=/dev/mapper/usrfs1 bs=4M
```

### 3.3.6  manual boot on nanopi

### 3.3.7 init script to mount automatically

```bash
 cd workspace/nano/buildroot/board/friendlyarm/nanopi-neo-plus2/rootfs_overlay/etc

 sudo cp /home/lmi/VM_SeS/luks_header/rand_key.txt ../etc
 mv rand_key.txt passphrase

 nano S40luks

```

```bash
#!/bin/sh

DEVICE=/dev/mmcblk0p3

cryptsetup --debug open --type luks $DEVICE usrfs1 --key-file passphrase

mkdir /mnt/usrfs

mount /dev/mapper/usrfs1 /mnt/usrfs

```

## 4 initramfs

```bash
./generate_initRAMfs.sh
./generate_s
```

