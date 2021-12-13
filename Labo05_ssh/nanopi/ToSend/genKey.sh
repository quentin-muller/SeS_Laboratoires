#!/bin/sh

# Generate keys
yes '' | ./ssh-keygen -t rsa -b 4096 -f rsa_4096 -q -N ""
yes '' | ./ssh-keygen -t dsa -b 1024 -f dsa_1024 -q -N ""
yes '' | ./ssh-keygen -t ecdsa -b 521 -f ecdsa_512 -q -N ""
yes '' | ./ssh-keygen -t ed25519 -b 256 -f ed25519_256 -q -N ""
# Generate host keys
./ssh-keygen -A
