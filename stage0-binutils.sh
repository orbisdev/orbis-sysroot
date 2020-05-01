ROOT=${PWD}
PS4SDK=$ROOT/toolchain_temp
git clone https://github.com/bminor/binutils-gdb
cd binutils-gdb
./configure --prefix=$PS4SDK --target="x86_64-pc-freebsd9" \
	--disable-nls \
	--disable-dependency-tracking \
	--disable-werror \
	--enable-ld \
	--enable-lto \
	--enable-plugins \
	--enable-poison-system-directories
make -j8
make install

cd $PS4SDK/bin
ln -s x86_64-pc-freebsd9-ld orbis-ld