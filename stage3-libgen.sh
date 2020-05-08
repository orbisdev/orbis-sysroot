#±/bin/bash
set -e

ROOT=${PWD}
PS4SDK=$ROOT/toolchain

wget https://github.com/orbisdev/orbis-libs-gen/releases/latest/download/libs.tar.gz

tar -zxvf libs.tar.gz