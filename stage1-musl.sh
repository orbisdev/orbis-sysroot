ROOT=${PWD}
PS4SDK=$ROOT/toolchain
PROC_NR=$(getconf _NPROCESSORS_ONLN)
GIT_REFERENCE=${1:-master}

rm -rf musl
mkdir musl
cd musl

git init
git remote add origin https://github.com/orbisdev/musl
git fetch --depth 1 origin ${GIT_REFERENCE}
git checkout FETCH_HEAD

CC=clang CFLAGS=--target=x86_64-scei-ps4 ./configure  --disable-shared  --prefix=$PS4SDK/usr --target=orbis
make -j $PROC_NR
make install