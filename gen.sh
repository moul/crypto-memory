#!/bin/sh

rm -rf out
mkdir -p out

# openssh rsa 4096
ssh-keygen -t rsa -b 4096 -C "" -f ./out/A -q -N ""
ssh-keygen -f out/A.pub -e -m pem > out/A.pem
openssl rsa -RSAPublicKey_in -in out/A.pem -inform PEM -outform DER -out out/A.der -RSAPublicKey_out

# openssh rsa 1024
ssh-keygen -t rsa -b 1024 -C "" -f ./out/B -q -N ""
ssh-keygen -f out/B.pub -e -m pem > out/B.pem
openssl rsa -RSAPublicKey_in -in out/B.pem -inform PEM -outform DER -out out/B.der -RSAPublicKey_out

# openssh ed25519
ssh-keygen -t ed25519 -C "" -f ./out/C -q -N ""
