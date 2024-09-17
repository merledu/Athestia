
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vkeccak_p.h"

vluint64_t sim_time = 0;

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

    Vkeccak_p* dut = new Vkeccak_p;

    Verilated::traceEverOn(true);
    VerilatedVcdC* m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 99);
    m_trace->open("keccak_p.vcd");

    dut->clk=0;
    dut->rst=1;
    dut->start=1;

    uint64_t value = 9140816709921147267ULL;

    // Split the 64-bit value into 32-bit parts and assign to the wide vector `S`
    dut->S[0] = static_cast<uint32_t>(value);          // Lower 32 bits of value
    dut->S[1] = static_cast<uint32_t>(value >> 32);
    for (int i = 0; i < 500; i++) {
    
        dut->clk = !dut->clk;

        if (i < 1) {
            dut->rst = 1; 
        } else {
            dut->rst = 0; 
        
        }
    dut->eval();
    m_trace->dump(sim_time++);
    }
    dut->final();
    m_trace->close();
    delete dut;
    return 0;
}
