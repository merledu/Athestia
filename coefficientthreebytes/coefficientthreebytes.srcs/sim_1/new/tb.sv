`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2024 12:15:49 PM
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


module tb_CoefFromThreeBytes;
    // Testbench variables
    logic [7:0] b0;
    logic [7:0] b1;
    logic [7:0] b2;
    logic [31:0] q;
    logic [23:0] coef;
    logic valid;

    // Instantiate the CoefFromThreeBytes module
    CoefFromThreeBytes uut (
        .b0(b0),
        .b1(b1),
        .b2(b2),
        .q(q),
        .coef(coef),
        .valid(valid)
    );

    // Test procedure
    initial begin
        // Initialize signals to known values to avoid z states in VCD
        b0 = 8'd0;
        b1 = 8'd0;
        b2 = 8'd0;
        q  = 32'd0;

        #5;  // Wait 5 time units for initialization

        // Test Case 1
        b0 = 8'd100;  // Byte 0
        b1 = 8'd90;   // Byte 1
        b2 = 8'd129;  // Byte 2 (shouldn't trigger b2_prime adjustment)
        q  = 32'd8380417; // Modulus q

        #10;  // Wait 10 time units to see the output
        $display("Test Case 1: coef = %0d, valid = %0d", coef, valid);

        $finish; // End simulation
    end
endmodule
