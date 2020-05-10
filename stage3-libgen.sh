#±/bin/bash
set -e

ROOT=${PWD}
PS4SDK=$ROOT/toolchain
ARCHIVE="ar -rcs"
ORBIS_BINUTILS=$ROOT/toolchain_temp/bin
# We need orbis-ld
PATH=$ORBIS_BINUTILS:$PATH

wget https://github.com/orbisdev/orbis-libs-gen/releases/latest/download/lib_s.tar.gz

rm -rf lib_s
tar -zxvf lib_s.tar.gz
cd lib_s

for d in `ls -d *`
do
    cd $d
    for i in *.S ; do
        clang --target=x86_64-scei-ps4 $i -c
    done
    ls *.o > ${d}_list.tmp
    xargs ${ARCHIVE} ${d}_stub.a < ${d}_list.tmp
    cd ..
done

find . -name '*.a' -exec cp \{\} $PS4SDK/usr/lib \;
