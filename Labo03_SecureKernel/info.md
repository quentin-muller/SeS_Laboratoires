# Labo 03

## Tricks 

### minicom

Quitter `ctlr a`(pour lancer une commande de minicom) puis `q` pour quitter 



## Question 1

### Configure a secure kernel  

1. dans le dossier `cd ~/workspace/nano/buildroot ` taper la commande -> `make linux-menuconfig` 

2. Dans `Platform selection` tout désactiver sauf `Allwinner sunxi 64-bit SoC Family` , `Broadcom BCM2835 family` 

3. Dans `General Setup` 

   1. Désactiver le `Kernel .config support` [ ] rien dans les accolades
   2. Désactiver le `Disable Heap randomization` [ ] rien dans les accolades
   3. Dans le sous dossier `Choose SLAB allocator (SLAB)` choisir SLAB
   4. Activer `Allow slab caches to be merged` et `SLAB freelist randomization` 
   5. Dans le sous dossier `Compiler optimization level`
      1. Choisir `Optimize for performance` 

4. Dans `General architecture-dependent options` activer `Stack Protector buffer overflow detection` et `Strong Stack Protector`

5. Dans `Kernel feature` 

   1. Activer `Randomize the address of the kernel image` 
   2. Activer `Apply r/o permissions of VM areas also to their linear aliases` 

6. Dans `Device drivers`

   1. Dans le sous `Character Devices` 
      1. Activer `Hardware Random Number Generator Core support`
      2. Dans le sous dossier `Hardware random number generator core support`
         1. Activer `Timer IOMEM HW Random Number Generator support `
         2. Activer `Broadcom BCM2835/BCM63xx Random Number Generator support  `

7. Dans `Kernel Hacking` 

   1. Activer `Filter access to /dev/mem`
   2. Activer `Filter I/O access to /dev/mem` 
   3. Dans le sous dossier `Compile time check and compiler options`
      1. Désactiver `Compile the kernel with debug info` 
      2. Activer `Strip assembler-generated symbols during link` 

8. Dans `Security options`

   1. Activer `Restrict unprivileged access to the kernel syslog` 
   2. Activer `Harden memory copies between kernel and userspace` puis `Allow usercopy whitelist violations to fallback to object size`
   3. Activer `Harden common str/mem functions against buffer overflows` 
   4. Dans le sous dossier `Kernel Hardening Options / Memory Initialization / Initialize Kernel Stack ...` 
      1. Activer `Enable heap memory zeroing on allocation by default  `
      2. Activer `Enable heap memory zeroing on free by default  `

9. Dans `Networking support / Networking options /[*] TCP IP Networking -> [*] IP: TCP syncookie support` activer 

10. Dans `File Systems` 

    1. ![Step to secure](C:\Users\quent\iCloudDrive\Documents\H_HES-SO\1er_semestre\MA_SeS\SeS_Laboratoires\Labo03_SecureKernel\StepSecure.PNG)

    

### Desactivate some kernel options  

Dans le dossier `workspace...`

commande `less .config` (Pour voir tout ce qui se trouve de le fichier .config de linux)

### For a next laboratory  

1. Dans `General Setup`
   1. Activer `Initial RAM File system and RAM Disk ...` 

### Compile, install and test the modifications  



## Question 2

`sysctl -w net.ipv4.ip_forward=0` désactive le mode routeur du nano-pi pour vérifier taper `cat /proc/sys/net/ipv4/ip_forward` dans le nano-pi ceci doit retourner 0

### Initialize /etc/sysctl.conf

Dans `workspace/nano/buildroot/board/friendlyarm/nanopi-neo-plus2/rootfs-overlay/etc` 

Si l'on fait `sudo nano sysctl.conf` on le crée en mode super user (root) ce qui bloque son utilisation par le système après coup 
il faut donc simplement faire `nano sysctl.conf` pour le crée normalement.

1. Exécuter la commande `nano sysctl.conf`

   1. Copier/Coller les commandes de la slide 39 de 3_complieKernel

      kernel.randomize_va_space=2
      net.ipv4.conf.lo.rp_filter=1
      net.ipv4.conf.eth0.rp_filter=1
      net.ipv4.conf.lo.accept_source_route=0
      net.ipv4.conf.eth0.accept_source_route=0
      net.ipv4.conf.lo.accept_redirects=0
      net.ipv4.conf.eth0.accept_redirects=0
      net.ipv4.icmp_echo_ignore_broadcasts=1
      net.ipv4.icmp_ignore_bogus_error_responses=1
      net.ipv4.conf.lo.log_martians=1
      net.ipv4.conf.eth0.log_martians=1
      net.ipv4.tcp_syncookies=1

### Write an initial script

Dans `workspace/nano/buildroot/board/friendlyarm/nanopi-neo-plus2/rootfs-overlay/etc`

1. Exécuter `mkdir init.d`
2. Exécuter `cd init.d`
3. Exécuter `nano S00KernelParameter`
4. Ecrire de ce fichier `sysctl -p`
5. `ctrl o` return `ctrl x`
6. Dans le dossier `workspace/nano/buildroot` 
   1. Exécuter `make`
7. utiliser le script generate.sh

#### Test [URL](https://linuxconfig.org/how-to-turn-on-off-ip-forwarding-in-linux)

1. Aller dans `/proc/sys/net/ipv4/` -> vérifier les commande de syctl.conf 
