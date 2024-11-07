`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2024 04:20:00 PM
// Design Name: 
// Module Name: Power2Round
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

`include "Parameters.sv"  // Include the parameters file

module Power2Round (
    input  logic signed [22:0] a,
    output logic signed [12:0] t0, // 13 bits for t0
    output logic signed [9:0] t1   // 10 bits for t1
);

    // Intermediate variable to calculate t1
    logic [22:0] a_plus_shift;

    always_comb begin
        // Use `D` from Parameters.sv for calculations
        a_plus_shift = a + (1 << (`D - 1)) - 1;
        t1 = a_plus_shift >>> `D;

        // Calculate a0 (t0) as a - (t1 << d)
        t0 = a - (t1 <<< `D);
    end

endmodule

