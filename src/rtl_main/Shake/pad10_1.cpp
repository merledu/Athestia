
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vpad10_1.h"

vluint64_t sim_time = 0;

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

    Vpad10_1* dut = new Vpad10_1;

    Verilated::traceEverOn(true);
    VerilatedVcdC* m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 99);
    m_trace->open("pad10_1.vcd");

    

    for (int i = 0; i < 1000; i++) {
    
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
