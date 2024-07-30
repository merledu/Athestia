#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vrandom_module.h"

vluint64_t sim_time = 0;

void tick(Vrandom_module* dut) {
    dut->clk = !dut->clk;
    dut->eval();
    sim_time++;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Vrandom_module* dut = new Vrandom_module;

    Verilated::traceEverOn(true);
    VerilatedVcdC* m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 99); 
    m_trace->open("rng.vcd");

    dut->clk = 0;
    dut->rst_n = 0;
    dut->enable = 0;

    dut->eval();
    m_trace->dump(sim_time++); 

    dut->rst_n = 1;
    dut->eval();
    m_trace->dump(sim_time++);

    dut->enable = 1;
    for (int i = 0; i < 10; i++) {
        tick(dut); // Toggle clock
        if (dut->clk) {
            std::cout << "Time: " << sim_time << "\nRandom Number: " << dut->number << std::endl;
        }
        m_trace->dump(sim_time++);
    }

    dut->final();
    m_trace->close();
    delete dut;
    return 0;
}
