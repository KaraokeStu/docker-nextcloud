#!/bin/bash
start_time="$(date -u +%s)"
apt update
apt -y install exiftool build-essential autoconf libtool git-core cmake wget ffmpeg imagemagick libmagickwand-dev
cd /usr/src/
git clone https://github.com/strukturag/libde265.git
git clone https://github.com/strukturag/libheif.git
cd libde265/
./autogen.sh
./configure
make -j$(nproc)
make install
cd /usr/src/libheif/
mkdir build
cd build
cmake --preset=release ..
make -j$(nproc)
make install
cd /usr/src/
wget https://github.com/ImageMagick/ImageMagick/archive/refs/tags/7.1.1-26.tar.gz
tar xf 7.1.1-26.tar.gz
cd ImageMagick-7*
./configure --with-heic=yes
make -j$(nproc)
make install
ldconfig
