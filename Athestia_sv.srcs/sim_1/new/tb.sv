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
module tb;
    parameter int ALPHA = 16;

    logic [ALPHA-1:0] x;
    logic [ALPHA-1:0] y;

    IntegerToBits #(.ALPHA(ALPHA)) uut (
        .x(x),
        .y(y)
    );

    initial begin
        x = 1023;  // Binary representation: 0000001111111111 in 16 bits
        #10;
        // Loop through each bit of y and display as an array of 0s and 1s
        for (int i = 0; i < ALPHA; i = i + 1) begin
            $write("%0d", y[i]);
            if (i < ALPHA - 1)
                $write(", ");
        end
        $finish;
    end
endmodule




// ******************************************************************************************//




// ******************************************************************************************//




// ******************************************************************************************//




// ******************************************************************************************//




// ******************************************************************************************//




// ******************************************************************************************//




// ******************************************************************************************//