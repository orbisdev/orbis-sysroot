ROOT=${PWD}
PS4SDK=$ROOT/toolchain
git clone https://github.com/orbisdev/musl
cd musl
CC=clang CFLAGS=--target=x86_64-scei-ps4 ./configure  --disable-shared  --prefix=$PS4SDK/usr --target=orbis
make -j4
make install