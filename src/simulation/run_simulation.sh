#!/bin/bash

g++ -c src/rtl_test/randtb.cpp
verilator -Wall --trace -cc src/rtl_main/random_module.sv --exe src/rtl_test/randtb.cpp
make -j -C obj_dir -f Vrandom_module.mk Vrandom_module
./obj_dir/Vrandom_module

#  gtkwave keygen.vcd