#±/bin/bash
set -e

sh stage0-binutils.sh
sh stage1-headers.sh
sh stage2-libgen.sh
sh stage3-libcxx.sh
tar -zcvf toolchain.tar.gz toolchain