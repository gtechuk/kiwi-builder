#!/bin/bash
#
# Script takes 2 arguments, the path to the configuration directory and the type
# of image to build (which should match up with a definition in configuration file)
#
set -e
set -u

WORKDIR=$(pwd)
OUTDIR=./out
SRCDIR=$1

echo ""
echo "Starting build"
echo ""
echo "WORKDIR=$(pwd)"

if [ ! -d "$SRCDIR" ] ; then
    echo "Source directory $SRCDIR does not exist "
    exit 1
fi

cd $SRCDIR
SRCDIR=$(pwd)
cd $WORKDIR

echo "SRCDIR=$SRCDIR"
echo "OUTDIR=$OUTDIR"
echo ""

echo "Checking for config file './config.xml'"

if [ ! -f "$SRCDIR/config.xml" ] ; then
    echo "Failed to find config file, but found: "
    echo "$(ls)"
    exit 1
fi


if [ -d "$SRCDIR/cdroot" ] ; then
    echo "Found cdroot directory, compressing to $SRCDIR/config-cdroot.tar.gz."
    
    cd "$SRCDIR/cdroot"
    tar -czf "$SRCDIR/config-cdroot.tar.gz" . 
    # Go back to original directory.
    cd "$WORKDIR"
fi


BUILD_DIR=/root/build

# Clear out tmp
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
mkdir -p $OUTDIR

echo "Starting build from $SRCDIR, with content:"
ls -la $SRCDIR

kiwi-ng \
    --debug \
    --type $2 system build \
    --description $SRCDIR \
    --target-dir $BUILD_DIR/image

echo "Clearing 'out' space"
rm -f $OUTDIR/*.iso || true
rm -f $OUTDIR/*.raw || true

# Copy iso files to output directory
if ls $BUILD_DIR/image/*.iso 1> /dev/null 2>&1; then
    echo "Copying iso files from $BUILD_DIR/image/ to $OUTDIR"
    cp $BUILD_DIR/image/*.iso $OUTDIR
else
    echo "No iso files to copy"
fi

if ls $BUILD_DIR/image/*.raw 1> /dev/null 2>&1; then
    cp $BUILD_DIR/image/*.raw $OUTDIR
else
    echo "No raw files to copy"
fi

cd $WORKDIR