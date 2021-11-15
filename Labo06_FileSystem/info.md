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

taper `ls /dev/root -al` pour savoir sur quelle stockage c'est fixé

taper `ls -al /dev/mmc*` regarder le résultat

## Question 2 filesystem

### 1. Create 2 new partitions (p3, p4) 

with fdisk

`sudo fdisk /dev/sdb`  puis n et p puis 3 -> 5'242'880

LA fin de la partition 2 est à 4'358'143 donc on peut utiliser la mémoire a partir de 4'358'144 le multiple rond de 1'048'576 est 5 fois soit 5'242'880

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

   1. installer les outils
   2. formater la partition en btrfs avec `sudo mkfs.btrfs /dev/sdb3`

   

2. f2fs