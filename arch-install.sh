#!/bin/bash

set -e

bump_gurobi() {
    grep -inlr 'gurobi90' . | xargs sed -i 's/gurobi90/gurobi91/'
}

git clone --depth 1 https://github.com/eth-sri/ERAN.git
cd ERAN
bump_gurobi

git clone https://github.com/eth-sri/ELINA.git
cd ELINA
bump_gurobi
sed -i 's|/usr/local/include/cddlib|$(CDD_PREFIX)|' fppoly/Makefile
./configure -use-deeppoly -use-gurobi -use-fconv --cdd-prefix /usr/include/cddlib
make
# make install
cd ..

git clone https://github.com/eth-sri/deepg.git
cd deepg/code
bump_gurobi
mkdir build
make shared_object
# cp ./build/libgeometric.so /usr/lib
cd ../..