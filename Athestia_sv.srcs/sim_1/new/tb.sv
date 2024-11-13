`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.11.2024 20:50:43
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


// ******************************************************************************************//
//module tb;
//    import Dilithium_pkg::*;
//    initial begin
//        $display("q = %d", q);
//        $display("zeta = %d", zeta);
//        $display("d = %d", d);
//        $display("tau = %d", tau);
//        $display("lambda = %d", lambda);
//        $display("gamma1 = %d", gamma1);
//        $display("gamma2 = %d", gamma2);
//        $display("k = %d", k);
//        $display("l = %d", l);
//        $display("eta = %d", eta);
//        $display("beta = %d", beta);
//        $display("omega = %d", omega);
//    end
//endmodule




// ******************************************************************************************//
//module tb;
//    logic signed [22:0] t;

//    logic signed [9:0]  t1;
//    logic signed [12:0] t0;

//    Power2round uut (
//        .t(t),
//        .t1(t1),
//        .t0(t0)
//    );

//    initial begin
//        $display("Time = %0t | t = %0d | t1 = %0d | t0 = %0d", $time, t, t1, t0);
//        t = 23'd7011276;
//        #10;
        
//        $finish;
//    end
//endmodule




// ******************************************************************************************//
//module tb;
//    parameter int ALPHA = 16;
//    parameter int BIT_WIDTH = 16;

//    logic [ALPHA-1:0] x;             // Input integer x
//    logic [BIT_WIDTH-1:0] y;         // Output bit array y

//    IntegerToBits #(
//        .ALPHA(ALPHA),
//        .BIT_WIDTH(BIT_WIDTH)
//    ) dut (
//        .x(x),
//        .y(y)
//    );
//    initial begin
//        x = 16'd1023;            
//        #10;
//        $display("x = %b, y = %b", x, y);
//        $finish;
//    end

//endmodule



module tb;
    parameter int ALPHA = 16;
    parameter int BIT_WIDTH = 16;

    logic [ALPHA-1:0] x;             // Input integer x
    logic [BIT_WIDTH-1:0] y;         // Output bit array y

    IntegerToBits #(
        .ALPHA(ALPHA),
        .BIT_WIDTH(BIT_WIDTH)
    ) dut (
        .x(x),
        .y(y)
    );

    initial begin
        // Initialize the input value
        x = 16'd1023; // Binary: 0000001111111111
        #10;          // Wait for 10 time units to allow processing

        // Display the input and output values
        $display("Input x (decimal): %d", x);
        $display("Input x (binary): %b", x);
        $display("Output y (bit array): %b", y);

        // Check for expected output: y should be [1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0]
        if (y === 16'b1111111111000000) begin
            $display("Test passed: Output y is correct.");
        end else begin
            $display("Test failed: Output y is incorrect.");
        end

        $finish; // End the simulation
    end
endmodule




// ******************************************************************************************//




// ******************************************************************************************//




// ******************************************************************************************//




// ******************************************************************************************//




// ******************************************************************************************//




// ******************************************************************************************//




// ******************************************************************************************//