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
swtpm socket --tpmstate dir=/home/lmi/server/tpm/swtpm2 --tpm2 --server type=tcp,port=2321 --ctrl type=tcp,port=2322 --flags not-need-init,startup-clear
```

## Installation de tpm2 tools

```bash
sudo dnf install tpm2-tss
sudo dnf install tpm2-tools
```

