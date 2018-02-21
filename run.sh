#!/bin/bash
#
# Script takes 2 arguments, the path to the configuration directory and the type
# of image to build (which should match up with a definition in configuration file)
#
set -e
set -u

# Clear out tmp
rm -rf /tmp/*
mkdir -p /out

kiwi-ng --type $2 system build \
    --description $1 \
    --target-dir /tmp/image

rm  -f /out/*.iso || true
rm  -f /out/*.raw || true

# Copy iso files to output directory
if ls /tmp/image/*.iso 1> /dev/null 2>&1; then
    cp /tmp/image/*.iso /out
else
    echo "No iso files to copy"
fi

if ls /tmp/image/*.raw 1> /dev/null 2>&1; then
    cp /tmp/image/*.raw /out
else
    echo "No raw files to copy"
fi