#±/bin/bash
set -e

ROOT=${PWD}
PS4SDK=$ROOT/toolchain

git clone --depth 1 https://github.com/orbisdev/orbis-headers.git

cd orbis-headers
# Remove all files, just keeping headers
find . -type f ! -iname "*.h" -delete

cp -r * $PS4SDK/usr/include