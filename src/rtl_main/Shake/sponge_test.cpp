#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vsponge.h"

uint64_t sim_time = 0;

void tick(Vsponge* dut) {
    dut->clk = !dut->clk;
    dut->eval();
    sim_time++;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Vsponge* dut = new Vsponge;

    Verilated::traceEverOn(true);
    VerilatedVcdC* m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 99); 
    m_trace->open("sponge.vcd");
    //
    dut->clk = 0;
    
    
    //dut->bitsponge=1;
    

    dut->eval();
    m_trace->dump(sim_time++); 
     
    dut->message=200;
    dut->start=1;
    //dut->capacity=512;
    dut->reset = 0;


   
    dut->eval();
    m_trace-> dump(sim_time++);
    //
    
    
    for (int i = 0; i <50; i++) {
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