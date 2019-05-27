#!/bin/sh -e

rm -rf out shuf
mkdir -p out shuf

(set -x

    # openssh rsa 4096
    ssh-keygen -t rsa -b 4096 -C "" -f ./out/A -q -N ""
    ssh-keygen -f ./out/A.pub -e -m pem > ./out/A.pem
    openssl rsa -RSAPublicKey_in -in ./out/A.pem -inform PEM -outform DER -out ./out/A.der -RSAPublicKey_out 2>/dev/null

    # openssh rsa 1024
    ssh-keygen -t rsa -b 1024 -C "" -f ./out/B -q -N ""
    ssh-keygen -f ./out/B.pub -e -m pem > ./out/B.pem
    openssl rsa -RSAPublicKey_in -in ./out/B.pem -inform PEM -outform DER -out ./out/B.der -RSAPublicKey_out 2>/dev/null

    # openssh ed25519
    ssh-keygen -t ed25519 -C "" -f ./out/C -q -N ""

    # openssl rsa 1024
    openssl genrsa -des3 -out ./out/D.with-password -passout pass:s3cur3 1024
    openssl rsa -in ./out/D.with-password -passin pass:s3cur3 -out ./out/D
    chmod 600 out/D
    ssh-keygen -y -f ./out/D > ./out/D.pub
    ssh-keygen -f ./out/D.pub -e -m pem > ./out/D.pem
    openssl rsa -RSAPublicKey_in -in ./out/D.pem -inform PEM -outform DER -out ./out/D.der -RSAPublicKey_out 2>/dev/null

    # openssh rsa 1024 (only the private key)
    ssh-keygen -t rsa -b 1024 -C "" -f ./out/E -q -N ""
    rm -f ./out/E.pub

    # openssh rsa 1024 (only the pub key)
    ssh-keygen -t rsa -b 1024 -C "" -f ./out/F -q -N ""
    ssh-keygen -f ./out/F.pub -e -m pem > ./out/F.pem
    openssl rsa -RSAPublicKey_in -in ./out/F.pem -inform PEM -outform DER -out ./out/F.der -RSAPublicKey_out 2>/dev/null
    rm -f ./out/F
)

# generated keys can be cleaned up with
#  cat ./out/A | sed '1d' | sed '$d'

# shuffle
counter=0
for file in $(ls ./out/* | shuf); do
    counter=$((counter+1))
    cp $file shuf/file_$counter
done

# zip
cd shuf; zip -r ./memory.zip .
