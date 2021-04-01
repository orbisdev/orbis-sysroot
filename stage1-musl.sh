#±/bin/bash
set -e

ROOT=${PWD}
PS4SDK=$ROOT/toolchain
PROC_NR=$(getconf _NPROCESSORS_ONLN)

## Download the source code.
REPO_URL="https://github.com/orbisdev/musl"
REPO_FOLDER="musl"
BRANCH_NAME="master"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || exit 1
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} || exit 1
fi

# Print latest commits
git log

## Configure
CC=clang CFLAGS=--target=x86_64-scei-ps4 ./configure  --disable-shared  --prefix=$PS4SDK/usr --target=orbis

## Compile and install.
make --quiet -j $PROC_NR clean   || { exit 1; }
make --quiet -j $PROC_NR || { exit 1; }
make --quiet -j $PROC_NR install || { exit 1; }
make --quiet -j $PROC_NR clean   || { exit 1; }