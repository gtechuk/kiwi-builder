#!/bin/bash
set -e
set -u

rm -rf /tmp/*
mkdir -p /out

kiwi-ng --type iso system build \
    --description $1 \
    --target-dir /tmp/myimage

rm  -f /out/*.iso || true
cp /tmp/myimage/*.iso /out