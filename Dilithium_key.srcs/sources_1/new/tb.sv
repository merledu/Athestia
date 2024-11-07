`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 03:36:11 PM
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


//module tb_CoefFromThreeBytes;
//    // Testbench variables
//    logic [7:0] b0;
//    logic [7:0] b1;
//    logic [7:0] b2;
//    logic [31:0] q;
//    logic [23:0] coef;
//    logic valid;

//    // Instantiate the CoefFromThreeBytes module
//    CoefFromThreeBytes uut (
//        .b0(b0),
//        .b1(b1),
//        .b2(b2),
//        .q(q),
//        .coef(coef),
//        .valid(valid)
//    );

//    // Test procedure
//    initial begin
//        // Initialize signals to known values to avoid z states in VCD
//        b0 = 8'd0;
//        b1 = 8'd0;
//        b2 = 8'd0;
//        q  = 32'd0;

//        #5;  // Wait 5 time units for initialization

//        // Test Case 1
//        b0 = 8'd100;  // Byte 0
//        b1 = 8'd90;   // Byte 1
//        b2 = 8'd129;  // Byte 2 (shouldn't trigger b2_prime adjustment)
//        q  = 32'd8380417; // Modulus q

//        #10;  // Wait 10 time units to see the output
//        $display("Test Case 1: coef = %0d, valid = %0d", coef, valid);

//        $finish; // End simulation
//    end
//endmodule













//power2round
module tb_Power2Round;
    // Testbench signals
    logic signed [22:0] a;         // Input to Power2Round (23-bit signed)
    logic signed [12:0] t0;        // Expected 13-bit output for t0
    logic signed [9:0] t1;         // Expected 10-bit output for t1

    // Instantiate the Power2Round module
    Power2Round uut (
        .a(a),
        .t0(t0),
        .t1(t1)
    );

    initial begin
        // Initialize values
        a = 0;
        
        // Display header
        $display("Time |    a        | Expected t0 | Expected t1 | Output t0 | Output t1");
        $display("---------------------------------------------------------------");

        // Test with various values of 'a'
        
        // Test case 1
        a = 23'sd7011276;
        #10;
        $display("%0t | %0d | %0d         | %0d         | %0d       | %0d", 
                 $time, a, t0, t1, uut.t0, uut.t1);

        #10;
        $stop;
    end

endmodule
