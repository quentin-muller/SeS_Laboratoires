#!/bin/sh

# Compilation
gcc mainQ4.c -o main
gcc mainQ4.c -o main_protected -fstack-protector-all

# Cross-compilation
# invoke gcc ARM compiler to compile main.c
aarch64-none-linux-gnu-gcc mainQ4.c -o main_aarch64 -fno-stack-protector
aarch64-none-linux-gnu-gcc mainQ4.c -o main_aarch64_protected -fstack-protector-all