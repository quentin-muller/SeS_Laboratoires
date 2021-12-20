#!/bin/sh

git clone https://github.com/stefanberger/swtpm.git

cd swtpm

sudo dnf -y install libtasn1-devel expect socat python3-twisted fuse-devel glib2-devel gnutls-devel gnutls-utils gnutls json-glib-devel

sudo dnf install libtpms-devel

sudo dnf install libseccomp-

./autogen.sh --with-openssl --prefix=/usr

make -j4

make -j4 check

sudo make install

export TPM2TOOLS_TCTI="swtpm:port=2321"

sudo dnf install tpm2-tss

sudo dnf install tpm2-tools