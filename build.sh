#±/bin/bash
set -e

sh prestage0-llvm.sh
sh stage0-binutils.sh
sh stage1-headers.sh
sh stage2-libgen.sh
sh stage3-libcxx.sh
ls -l usr/include/c++/v1
ls -l usr/lib
# sh stage4-ps4sdk-headers.sh
# tar -zcvf toolchain.tar.gz toolchain
