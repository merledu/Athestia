verilator -Wall --trace -cc src/main/$1.sv --exe src/test/adder_test.cpp
make -j -C obj_dir -f V$1.mk V$1
./obj_dir/V$1

