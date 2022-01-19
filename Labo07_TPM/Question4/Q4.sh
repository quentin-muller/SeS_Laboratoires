#!/bin/sh

echo "----- BEGIN -----"

echo "----- Calcul du hash -----"
sha1sum Image

echo "----- Effacer precedente config -----"
tpm2_pcrreset 0

echo "----- Configuration PCR 0 -----"
tpm2_pcrextend 0:sha1=<HASH_IMAGE>

tpm2_createprimary -C o –G rsa2048 -c primary
tpm2_startauthsession -S session
tpm2_policypcr -S session -l sha1:0 -L pcr0_policy
tpm2_flushcontext session


tpm2_create -C primary -g sha256 \
-u passwd_pcr0.pub -r passwd_pcr0.priv \
–i passwd -L pcr0_policy

echo "----- Sauvegarde dans la Nv-RAM -----"
tpm2_load -C primary -u passwd_pcr0.pub \
-r passwd_pcr0.priv -c passwd_pcr

tpm2_evictcontrol -c passwd_pcr0 0x81010000 -C o
tpm2_flushcontext session

echo "--- Comparaison entre PCR0 et actuel -----"
tpm2_startauthsession --policy-session -S session
tpm2_policypcr -S session -l sha1:0
tpm2_unseal -p session:session -c 0x81010000 > passwd
