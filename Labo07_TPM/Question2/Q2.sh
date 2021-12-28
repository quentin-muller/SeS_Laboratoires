#!/bin/sh

echo "--------------- Begin ---------------"

echo "-------- Flush previous code --------"
tpm2_flushcontext -t
tpm2_evictcontrol -c 0x81000000 2> /dev/null
tpm2_evictcontrol -c 0x81000001 2> /dev/null
tpm2_evictcontrol -c 0x81000002 2> /dev/null
tpm2_evictcontrol -c 0x81000003 2> /dev/null

echo "------ Create primary owner key ------"
tpm2_createprimary -C o -G rsa2048 -c primary

echo "------- Create child owner key -------"
tpm2_create -C primary -G rsa2048 -u child_public -r child_private

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

echo "---------------- DONE ----------------"