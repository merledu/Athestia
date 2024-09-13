
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vpi.h"

vluint64_t sim_time = 0;

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

    Vpi* dut = new Vpi;

    Verilated::traceEverOn(true);
    VerilatedVcdC* m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 99);
    m_trace->open("matrix_transpose.vcd");

    dut->clk=0;
    dut->rst=1;

    dut->A[0][0]=9140816709921147267;
    dut->A[0][1] = 16660763579284450526ULL;
    dut->A[0][2] =2531690476160191240;
    dut->A[0][3] =8592519701077706487;
    dut->A[0][4] =2759389626702462872;

    dut->A[1][0]=4652495107889034528;
    dut->A[1][1] = 9316628960091983002ULL;
    dut->A[1][2] =15981364012095333263ULL;
    dut->A[1][3] =9171576544632330341;
    dut->A[1][4] =7799675968790151315;

    dut->A[2][0]=11453938305225657984ULL;
    dut->A[2][1] = 11460808520894713465ULL;
    dut->A[2][2] =10773324431134918268ULL;
    dut->A[2][3] =2675531708788547881;
    dut->A[2][4] =11228439929677099189ULL;

    dut->A[3][0] = 13637637338296810837ULL;
    dut->A[3][1] = 5854353887206805552;
    dut->A[3][2] = 8952631530992532258;
    dut->A[3][3] = 6732916416155517485;
    dut->A[3][4] = 1094056101888795800;

    dut->A[4][0] = 13637637338296810837ULL;
    dut->A[4][1] = 5854353887206805552;
    dut->A[4][2] = 8952631530992532258;
    dut->A[4][3] = 6732916416155517485;
    dut->A[4][4] = 1094056101888795800;

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
