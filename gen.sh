#!/bin/sh -e

rm -rf out shuf
mkdir -p out shuf

(set -x

    # openssh rsa 4096
    ssh-keygen -t rsa -b 4096 -C "" -f ./out/A -q -N ""
    ssh-keygen -f out/A.pub -e -m pem > out/A.pem
    openssl rsa -RSAPublicKey_in -in out/A.pem -inform PEM -outform DER -out out/A.der -RSAPublicKey_out 2>/dev/null

    # openssh rsa 1024
    ssh-keygen -t rsa -b 1024 -C "" -f ./out/B -q -N ""
    ssh-keygen -f out/B.pub -e -m pem > out/B.pem
    openssl rsa -RSAPublicKey_in -in out/B.pem -inform PEM -outform DER -out out/B.der -RSAPublicKey_out 2>/dev/null

    # openssh ed25519
    ssh-keygen -t ed25519 -C "" -f ./out/C -q -N ""
)

# shuffle
counter=0
for file in $(ls out/*); do
    counter=$((counter+1))
    cp $file shuf/$counter
done
