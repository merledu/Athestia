`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 17:49:15
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

module tb;
    parameter int width = 32;
    parameter int r1_width = 32;
    parameter int r0_width = 32;

    logic [width-1:0] r;
    logic signed [r1_width-1:0] r1;
    logic signed [r0_width-1:0] r0;

    Decompose #(.width(width), .r1_width(r1_width), .r0_width(r0_width) ) dut (
        .r(r),
        .r1(r1),
        .r0(r0)
    );

    initial begin
        $display("Starting Decompose Testbench");

        r = 3848922;
        #10;
        $display("Test Case 1: r = %d", r);
        $display("Result: r1 = %d, r0 = %d", r1, r0);

        r = 3826724;
        #10;
        $display("Test Case 2: r = %d", r);
        $display("Result: r1 = %d, r0 = %d", r1, r0);

        r = 6766760;
        #10;
        $display("Test Case 3: r = %d", r);
        $display("Result: r1 = %d, r0 = %d", r1, r0);

        $display("Testbench completed.");
        $stop;
    end

endmodule