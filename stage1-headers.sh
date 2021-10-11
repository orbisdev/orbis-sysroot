#±/bin/bash
set -e

ROOT=${PWD}
PS4SDK=$ROOT

git clone --depth 1 https://github.com/orbisdev/orbisdev-headers.git -b sce

cd orbisdev-headers

mkdir -p $PS4SDK/usr/include/

cp -r include/* $PS4SDK/usr/include/

