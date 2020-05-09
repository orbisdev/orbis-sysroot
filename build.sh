#±/bin/bash
set -e

sh stage0-binutils.sh
sh stage1-musl.sh $1
sh stage2-libcxx.sh
sh stage3-libgen.sh
tar -zcvf toolchain.tar.gz toolchain