#!/bin/sh 

echo "--------------- Begin ---------------"

echo "-------- Flush previous key ---------"
tpm2_flushcontext -t
tpm2_evictcontrol -c 0x81000000 2> /dev/null
tpm2_evictcontrol -c 0x81000001 2> /dev/null
tpm2_evictcontrol -c 0x81000002 2> /dev/null
tpm2_evictcontrol -c 0x81000003 2> /dev/null

echo "------- Load private kex (RAM) -------"
tpm2_loadexternal -C n -G rsa -r rsa_key.pem -c rsa_key

echo "------ Show transient key (RAM) ------"
tpm2_getcap handles-transient

echo "---- Decrypt with the private key ----"
tpm2_rsadecrypt -c 0x80000000 -s rsaes encryptedtext -o cleartext

echo "-------- Print decrypted text --------"
cat cleartext
echo ""

echo "---------------- DONE ----------------"