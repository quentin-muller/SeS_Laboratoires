# Labo 07 TPM

## Initialisation de swtpm (virtual tpm)

```bash
git clone https://github.com/stefanberger/swtpm.git

cd swtpm

sudo dnf -y install libtasn1-devel expect socat python3-twisted fuse-devel glib2-devel gnutls-devel gnutls-utils gnutls json-glib-devel

sudo dnf install libtpms-devel

sudo dnf install libseccomp-devel

./autogen.sh --with-openssl --prefix=/usr

make -j4

make -j4 check

sudo make install

export TPM2TOOLS_TCTI="swtpm:port=2321"
```

## Démarrage de swtpm

```bash
cd
mkdir server
cd server
mkdir tpm 
cd tpm
mkdir swtpm2
cd
```

```bash
swtpm socket --tpmstate dir=/home/lmi/server/tpm/swtpm2 --tpm2 --server type=tcp,port=2321 --ctrl type=tcp,port=2322 --flags not-need-init,startup-clear
```

## Installation de tpm2 tools

```bash
sudo dnf install tpm2-tss
sudo dnf install tpm2-tools
```

## Question 1

### 1.1 Create primary owner key with rsa2048

```bash
tpm2_createprimary -C o -G rsa2048 -c o_primary.ctx

tpm2_getcap handles-transient

tpm2_flushcontext -t

tpm2_createprimary -C o -G rsa2048 -c o_primary.ctx

tpm2_evictcontrol -c o_primary.ctx

tpm2_getcap handles-transient

tpm2_getcap handles-persistent 2> /dev/null
```

## Question 2

```bash
echo "------ Create primary owner key ------"
tpm2_createprimary -C o -G rsa2048 -c primary

echo "------- Create child owner key -------"
tpm2_create -C primary -G rsa2048 -u child_public -r child_private -c child_key

echo "------ Show transient key (RAM) ------"
tpm2_getcap handles-transient

echo "---- Show persistent key (NV-RAM) ----"
tpm2_getcap handles-persistent

#echo "----- Load child owner key (RAM) -----"
#tpm2_load -C primary -u child_public -r child_private -c child

echo "------ Save owner key in NV-RAM ------"
tpm2_evictcontrol -c 0x80000001

echo "------ Show transient key (RAM) ------"
tpm2_getcap handles-transient

echo "---- Show persistent key (NV-RAM) ----"
tpm2_getcap handles-persistent
```

## Question 3

![Schéma d'encryption asymétrique](Question3/Figures/SchemaCrypt.png)

```bash
echo "------- Load private kex (RAM) -------"
tpm2_loadexternal -C n -G rsa -r rsa_key.pem -c rsa_key

echo "------ Show transient key (RAM) ------"
tpm2_getcap handles-transient

echo "---- Decrypt with the private key ----"
tpm2_rsadecrypt -c 0x80000000 -s rsaes encryptedtext -o cleartext

echo "-------- Print decrypted text --------"
cat cleartext
```

