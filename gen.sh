#!/bin/sh

mkdir -p out
ssh-keygen -t rsa -b 4096 -C "" -f ./out/A -q -N ""
ssh-keygen -t ed25519 -C "" -f ./out/B -q -N ""
ssh-keygen -t rsa -b 1024 -C "" -f ./out/C -q -N ""
