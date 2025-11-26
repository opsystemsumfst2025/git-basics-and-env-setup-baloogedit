#!/bin/bash

# 1. Compile the C code
echo "Compiling C Code..."
gcc sys_check.c -o sys_check

# 2. Run the C code and save output to a file
echo "Running System Check..."
./sys_check > proof.txt

# 3. APPEND the contents of the secret kernel file
echo "------------------------------------------------" >> proof.txt
echo "KERNEL DEEP CHECK:" >> proof.txt
cat /proc/version >> proof.txt
echo "------------------------------------------------" >> proof.txt

echo "Verification Complete. 'proof.txt' generated."
