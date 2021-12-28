#!/bin/sh 

tpm2_loadexternal -C n -G rsa -r rsa_key.pem -c rsa_key

echo "------ Show transient key (RAM) ------"
tpm2_getcap handles-transient

echo "---- Show persistent key (NV-RAM) ----"
tpm2_getcap handles-persistent

echo "------ Save owner key in NV-RAM ------"
tpm2_evictcontrol -c 0x80000000

# decrypt with the private key p.43
#tpm2_rsadecrypt -c rsa_key -s rsaes encryptedtext -o cleartext