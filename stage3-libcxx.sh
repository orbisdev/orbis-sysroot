#±/bin/bash
set -e

ROOT=${PWD}
PS4SDK=$ROOT/toolchain

ORBIS_BINUTILS=$ROOT/toolchain_temp/bin
# We need orbis-ld
PATH=$ORBIS_BINUTILS:$PATH

## Download the source code.
REPO_URL="https://github.com/llvm/llvm-project.git"
REPO_FOLDER="llvm-project"
BRANCH_NAME="llvmorg-13.0.0"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || exit 1
else
	cd $REPO_FOLDER || exit 1
fi

patch -p1 < ../llvm_patches.diff

cd libunwind
mkdir -p build
cd build

cmake \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_CXX_FLAGS=-D_BSD_SOURCE \
    -DLIBUNWIND_TARGET_TRIPLE=x86_64-scei-ps4 \
    -DLIBUNWIND_ENABLE_SHARED=OFF \
    -DLIBUNWIND_ENABLE_STATIC=ON \
    -DLIBUNWIND_USE_COMPILER_RT=ON \
    -DLIBUNWIND_SYSROOT=$PS4SDK \
    -DCMAKE_INSTALL_PREFIX=$PS4SDK/usr \
    -DLLVM_PATH=../../llvm \
    -G Ninja \
    ..
cmake --build . 
cmake --build . --target install

cd ../../libcxx
mkdir -p build
cd build

cmake \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_CXX_FLAGS="-D_BSD_SOURCE -D__ORBIS__ -frtti -fexceptions" \
    -DLIBCXX_TARGET_TRIPLE=x86_64-scei-ps4 \
    -DLIBCXX_CXX_ABI=libcxxabi \
    -DLIBCXX_CXX_ABI_INCLUDE_PATHS=../../libcxxabi/include \
    -DLIBCXX_CXX_ABI_LIBRARY_PATH=../../libcxxabi/build/lib \
    -DLIBCXX_ENABLE_SHARED=OFF \
    -DLIBCXX_SYSROOT=$PS4SDK \
    -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=OFF \
    -DLIBCXX_USE_COMPILER_RT=YES \
    -DCMAKE_INSTALL_PREFIX=$PS4SDK/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_PATH=../../llvm \
    -G Ninja \
    ..
cmake --build . 
cmake --build . --target install

cd ../../libcxxabi
mkdir -p build
cd build


cmake \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_CXX_FLAGS="-D_BSD_SOURCE -frtti -fexceptions " \
    -DLIBCXXABI_TARGET_TRIPLE=x86_64-scei-ps4 \
    -DCMAKE_SHARED_LINKER_FLAGS="-L../../libunwind/build/lib" \
    -DLIBCXXABI_USE_LLVM_UNWINDER=ON \
    -DLIBCXXABI_ENABLE_SHARED=OFF \
    -DLIBCXXABI_USE_COMPILER_RT=YES \
    -DLIBCXXABI_INCLUDE_TESTS=OFF \
    -DLIBCXXABI_LIBCXX_INCLUDES=$PS4SDK/usr/include/c++/v1/ \
    -DLIBCXXABI_SYSROOT=$PS4SDK \
    -DCMAKE_INSTALL_PREFIX=$PS4SDK/usr \
    -DLLVM_PATH=../../llvm \
    -G Ninja \
    ..
cmake --build . 
cmake --build . --target install