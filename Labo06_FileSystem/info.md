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

