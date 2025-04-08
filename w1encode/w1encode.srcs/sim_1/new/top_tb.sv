`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2024 02:38:06 PM
// Design Name: 
// Module Name: tb
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

module tb_top_three_bytes;

    // Parameters
    parameter int q = 8380417;

    // Testbench signals
    logic btn;
    logic clk;
    logic rst;
    logic led;

    // DUT instance
    top dut (
        .btn(btn),
        .clk(clk),
        .rst(rst),
        .led(led)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Stimulus
    initial begin
        // Initialize signals
        rst = 1;
        btn = 0;
        #20;

        // Release reset
        rst = 0;
        #10;

        // Test case 1: Toggle button
        btn = 1;
        #10;
        btn = 0;
        #20;

//        // Test case 2: Reset again
//        rst = 1;
//        #10;
//        rst = 0;
//        #10;

        // End simulation
        #50;
        $finish;
    end



endmodule
