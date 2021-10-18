# Labo 03

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
      1. Desactiver `Compile the kernel with debug info` 
      2. Activer `Strip assembler-generated symbols during link` 

8. Dans `Security options`

   1. Activer `Restrict unprivileged access to the kernel syslog` 
   2. Activer `Harden memory copies between kernel and userspace` puis `Allow usercopy whitelist violations to fallback to object size`
   3. Activer `Harden common str/mem functions against buffer overflows` 
   4. Dans le sous dossier `Kernel Hardening Options / Memory Initialization / Initialize Kernel Stack ...` 
      1. Activer `Enable heap memory zeroing on allocation by default  `
      2. Activer `Enable heap memory zeroing on free by default  `

9. Dans `Networking support / Networking options /[*] TCP IP Networking -> [*] IP: TCP syncookie support` acitver 

10. Dans `File Systems` 

    1. ![Step to secure](C:\Users\quent\iCloudDrive\Documents\H_HES-SO\1er_semestre\MA_SeS\SeS_Laboratoires\Labo03_SecureKernel\StepSecure.PNG)

    

### Desactivate some kernel options  

### For a next laboratory  

### Compile, install and test the modifications  

