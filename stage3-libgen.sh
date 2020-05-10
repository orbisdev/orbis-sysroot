#±/bin/bash
set -e

ROOT=${PWD}
PS4SDK=$ROOT/toolchain
ORBIS_BINUTILS=$ROOT/toolchain_temp/bin
# We need orbis-ld
PATH=$ORBIS_BINUTILS:$PATH

wget https://github.com/orbisdev/orbis-libs-gen/releases/latest/download/lib_s.tar.gz

rm -rf lib_s
tar -zxvf lib_s.tar.gz
cd lib_s

for d in */ ; do
    cd $d
    for i in *.S ; do
        clang --target=x86_64-scei-ps4 $i -c
        ar -rcs ${i%.S}_stub.a ${i%.S}.o
    done
    cd ..
done

find . -name '*.a' -exec cp --parents \{\} $PS4SDK/usr/lib \;
