#!/bin/bash

verilator -Wall --trace -cc rtl_main/SHAKE256_sv/inmem.sv rtl_main/SHAKE256_sv/KECCAK_f.sv rtl_main/SHAKE256_sv/control_unit.sv rtl_main/SHAKE256_sv/pad.sv rtl_main/SHAKE256_sv/S_to_A.sv rtl_main/SHAKE256_sv/round_counter.sv rtl_main/SHAKE256_sv/Rnd.sv rtl_main/SHAKE256_sv/A_to_S.sv rtl_main/SHAKE256_sv/theta.sv rtl_main/SHAKE256_sv/rho.sv rtl_main/SHAKE256_sv/chi.sv rtl_main/SHAKE256_sv/iota.sv rtl_main/SHAKE256_sv/rc.sv rtl_main/SHAKE256_sv/pi.sv rtl_main/SHAKE256_sv/SHAKE256.sv --exe rtl_test/shake256_tb.cpp
make -j -C obj_dir -f VSHAKE256.mk VSHAKE256
./obj_dir/VSHAKE256

