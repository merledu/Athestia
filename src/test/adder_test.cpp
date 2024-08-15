#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "VAes_ctr.h"

vluint64_t sim_time = 0;

void tick(VAes_ctr* dut) {
    dut->clk = !dut->clk;
    dut->eval();
    sim_time++;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    VAes_ctr* dut = new VAes_ctr;

    Verilated::traceEverOn(true);
    VerilatedVcdC* m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 99); 
    m_trace->open("Aes_ctr.vcd");
    //
    dut->clk = 0;
    dut->reset = 0;
    //dut->enable = 0;

    dut->eval();
    m_trace->dump(sim_time++); 

    dut->reset = 0;
    dut->eval();
    m_trace->dump(sim_time++);
    //
    
    
    for (int i = 0; i < 20; i++) {
        tick(dut); // Toggle clock
       //  if (dut->clk) {
         //    std::cout << "Time: " << sim_time << "\nRandom Number: " << dut->number << std::endl;
        // }
        m_trace->dump(sim_time++);
    }

    dut->final();
    m_trace->close();
    delete dut;
    return 0;
}