#±/bin/bash
set -e

bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 13
