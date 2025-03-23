`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/22/2024 06:15:40 PM
// Design Name: 
// Module Name: w1encode
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


module w1encode #(
    parameter int k = 4,
    parameter int q = 8380417,
    parameter int gamma = (q-1)/32,
    parameter int widht = 4 // Corrected typo
) (
    input logic clk,
    input logic reset,
    //input logic start,
//    (* keep = "true" *) input logic [widht-1:0] w1[0:k-1][0:255],  // Corrected parameter name
//    (* dont_touch = "true" *) input logic [widht-1:0] w1_flat[0:(k*256)-1],
//    (* dont_touch = "true" *) output logic [widht-1:0] w1_out[0:(k*256)-1]
        input logic [widht-1:0] w1_flat[0:255],
        output logic [widht-1:0] w1_out[0:255]
    //output logic done,
    //output logic [256*k*widht-1:0] w1_hat  // Width calculation matches testbench
);
//always_comb begin
assign w1_out = w1_flat;
//end
endmodule
