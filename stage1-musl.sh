ROOT=${PWD}
PS4SDK=$ROOT/toolchain
PROC_NR=$(getconf _NPROCESSORS_ONLN)
git clone --depth 1 https://github.com/orbisdev/musl
cd musl
CC=clang CFLAGS=--target=x86_64-scei-ps4 ./configure  --disable-shared  --prefix=$PS4SDK/usr --target=orbis
make -j $PROC_NR
make install