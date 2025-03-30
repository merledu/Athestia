`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2025 06:09:01
// Design Name: 
// Module Name: ringOscillatorTop_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module ringOscillatorTop_tb;

    logic clk, rst;
    logic rand_xor;

    // Instantiate the DUT (SanityCheck module)
    ringOscillatorTop dut (
        .clk(clk),
        .rst(rst),
        .rand_xor(rand_xor)
    );

    // Initialize Test
    initial begin
        int i, j;  // Declare loop variables inside the initial block

        $display("Starting Sanity Check Testbench...");
        clk = 0;
        rst = 1;
        #10;
        rst = 0;
        #20
        $finish;
        end
        
       always begin
                #0.1 clk = ~clk;
            end
            
            initial begin
                $dumpfile("ringOscillatorTop_tb.vcd");
                $dumpvars(0,ringOscillatorTop_tb);
            end
        
      
endmodule
