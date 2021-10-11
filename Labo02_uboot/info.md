# Labo 02 sur uboot

## Question 1 modifier le prompt

Dans buildroot lancer la commande 

```bash
make uboot-menuconfig
```

Puis dans command line interface puis shell prompt modifier => par Nano Pi \#

## Question 2

1. dans le script generate -> modification des fat en ext4 (l 28, 32)
2. dans le dossier `workspace/nano/buildroot/board/friendlyarm/nanopi-neo-plus2`  avec la commande `sudo nano boot.cmd` modifier le fatload en ext4load (ctrl o, ctrl x)
3. Recréer le fichier `boot.src` avec la commande ` mkimage -C none -A arm64 -T script -d board/friendlyarm/nanopi-neo-plus2/boot.cmd /home/lmi/workspace/nano/buildroot/output/images/boot.scr  ` dans le dossier buildroot
4. utiliser le script generate.sh

## Question 3  [URL](https://www.ionos.fr/assistance/serveurs-et-cloud/serveur-dedie-pour-les-serveurs-achetes-avant-le-28102018/reseau/modifier-ou-ajouter-une-adresse-ipv4-a-un-serveur-dedie-linux/#c180519)

1. démarrer nano pi
2. dans etc/network modifier interfaces `vi interfaces` 
3. modifier selon l'url (192.168.0.11 -> gateway 192.168.0.4)
4. redémarrer le nano pi

