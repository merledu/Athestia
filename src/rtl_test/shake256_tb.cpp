#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "VSHAKE256.h"

vluint64_t sim_time = 0;

void tick(Vrandom_module* dut) {
    dut->clock = !dut->clock;
    dut->eval();
    sim_time++;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    VSHAKE256* dut = new VSHAKE256;

    Verilated::traceEverOn(true);
    VerilatedVcdC* m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 99); 
    m_trace->open("rng.vcd");

    dut->clock = 0;
    dut->reset = 0;
    dut->message = 15;
    dut->length = 256

    dut->eval();
    m_trace->dump(sim_time++); 

    dut->reset = 1;
    dut->eval();
    m_trace->dump(sim_time++);

    dut->message = 1;
    for (int i = 0; i < 50; i++) {
        tick(dut); // Toggle clock
        // if (dut->clock) {
        //     std::cout << "Time: " << sim_time << "\nRandom Number: " << dut->number << std::endl;
        // }
        m_trace->dump(sim_time++);
    }

    dut->final();
    m_trace->close();
    delete dut;
    return 0;
}
