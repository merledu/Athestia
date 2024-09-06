#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "VX.h"

vluint64_t sim_time = 0;

void tick(VX* dut) {
    dut->clk = !dut->clk;
    dut->eval();
    sim_time++;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    VX* dut = new VX;

    Verilated::traceEverOn(true);
    VerilatedVcdC* m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 99); 
    m_trace->open("X.vcd");
    //
    dut->clk = 0;
    dut->reset = 1;
  //  dut->bitX=1;
    

    dut->eval();
    m_trace->dump(sim_time++); 


    //dut->reset = 0;
    dut->A[0][0]=1;
    // dut->A[0][0][1]=1;
    // dut->A[0][0][2]=1;
    // dut->A[1][0][1]=0;
    // dut->A[2][0][2]=1;
    


    dut->A[1][0]=1;
    dut->A[2][0]=1;
    // //dut->a=2;
    //dut->b=3;

    
   
    //dut->bitX = 1;
    //dut->enable = 0;
    dut->eval();
    m_trace-> dump(sim_time++);
    //
    
    
    for (int i = 0; i <1; i++) {
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