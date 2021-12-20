#!/bin/sh

tpm2_createprimary -C o -G rsa2048 -c o_primary.ctx

tpm2_getcap handles-transient

tpm2_flushcontext -t

tpm2_createprimary -C o -G rsa2048 -c o_primary.ctx

tpm2_evictcontrol –c o_primary.ctx

tpm2_getcap handles-transient

tpm2_getcap handles-persistent

