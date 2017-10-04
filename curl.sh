#!/bin/bash

set -e
set -x

ZLIB_VER='zlib-1.2.11'
OPENSSL_VER='openssl-1.0.2l'
CURL_VER='curl-7.55.1'

mkdir -p ./buildcurl && cd ./buildcurl

BASE=`pwd`
SRC=$BASE/src
WGET="wget --prefer-family=IPv4"
DEST=$BASE/opt
LDFLAGS="-L$DEST/lib -Wl,--gc-sections"
CPPFLAGS="-I$DEST/include"
CFLAGS="-mtune=mips32 -mips32 -ffunction-sections -fdata-sections"
CXXFLAGS=$CFLAGS
CONFIGURE="./configure --prefix=/opt --host=mipsel-linux"
MAKE="make -j`nproc`"
mkdir -p $SRC

######## ####################################################################
# ZLIB # ####################################################################
######## ####################################################################

mkdir -p $SRC/zlib && cd $SRC/zlib
$WGET http://zlib.net/$ZLIB_VER.tar.gz
tar zxvf $ZLIB_VER.tar.gz
cd $ZLIB_VER

LDFLAGS=$LDFLAGS \
CPPFLAGS=$CPPFLAGS \
CFLAGS=$CFLAGS \
CXXFLAGS=$CXXFLAGS \
CROSS_PREFIX=mipsel-linux- \
./configure \
--prefix=/opt

$MAKE
make install DESTDIR=$BASE

########### #################################################################
# OPENSSL # #################################################################
########### #################################################################

mkdir -p $SRC/openssl && cd $SRC/openssl
$WGET http://www.openssl.org/source/$OPENSSL_VER.tar.gz
tar zxvf $OPENSSL_VER.tar.gz
cd $OPENSSL_VER

./Configure linux-mips32 \
-ffunction-sections -fdata-sections -Wl,--gc-sections \
--prefix=/opt shared zlib zlib-dynamic \
--with-zlib-lib=$DEST/lib \
--with-zlib-include=$DEST/include

make CC=mipsel-linux-gnu-gcc
make install CC=mipsel-linux-gnu-gcc INSTALLTOP=$DEST OPENSSLDIR=$DEST/ssl

######## ####################################################################
# CURL # ####################################################################
######## ####################################################################

mkdir -p $SRC/curl && cd $SRC/curl
$WGET http://curl.haxx.se/download/$CURL_VER.tar.gz
tar zxvf $CURL_VER.tar.gz
cd $CURL_VER

LDFLAGS=$LDFLAGS \
CPPFLAGS=$CPPFLAGS \
CFLAGS=$CFLAGS \
CXXFLAGS=$CXXFLAGS \
$CONFIGURE \
--with-zlib=$DEST \
--with-ssl=$DEST

$MAKE LIBS="-all-static -ldl -pthread"
make install DESTDIR=$BASE/curl
