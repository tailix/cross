#!/bin/sh

set -e

REPO="$(realpath "$(dirname "$(realpath "$0")")/../..")"

ARCH='x86_64'
TARGET="$ARCH-elf"

ROOT="$REPO/root"
PATH="$ROOT/bin:$PATH"

if [ -z "$J" ]; then J='1'; fi

cd "$REPO/build/$ARCH/binutils"
"$REPO/src/binutils-2.37/configure" --target="$TARGET" --prefix="$ROOT" --with-sysroot --disable-nls --disable-werror
make -j"$J"
make install

cd "$REPO/build/$ARCH/gcc"
"$REPO/src/gcc-11.2.0/configure" --target="$TARGET" --prefix="$ROOT" --disable-nls --enable-languages=c,c++ --without-headers
make -j"$J" all-gcc all-target-libgcc
make install-gcc install-target-libgcc
