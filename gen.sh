#!/bin/sh

mkdir -p out
ssh-keygen -t rsa -b 4096 -C "" -f ./out/A -q -N ""
