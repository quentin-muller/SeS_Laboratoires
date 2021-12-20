#!/bin/sh

echo "--- start swtpm server ---"

swtpm socket --tpmstate dir=/home/lmi/server/tpm/swtpm2 --tpm2 --server type=tcp,port=2321 --ctrl type=tcp,port=2322 --flags not-need-init,startup-clear
