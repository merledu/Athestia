`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2024 09:24:28
// Design Name: 
// Module Name: simpleBitUnpack
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

//module SimpleBitPack #(
//    parameter int W_WIDTH = 8  // Width of the coefficients in w
////    parameter int B_WIDTH = 8   // Width of the integer b
//)(
//    input logic [W_WIDTH-1:0] w [255:0],  // Input array w of 256 elements
////    input logic [B_WIDTH-1:0] b,          // Input integer b
//    output logic [(256 * W_WIDTH) - 1:0] z  // Output packed bitstream z
//);
//    logic [(256 * W_WIDTH) - 1:0] z_bits;  // Final packed bits array
module PolynomialConverter #(
    parameter int bitlen_b = 10 // Change as needed
    )

(
    input logic clk,
    input logic reset,
    input logic [256*bitlen_b-1:0] v, // Byte string of length 32 * bitlen(b)
    output logic [bitlen_b-1:0] w[255:0] // Polynomial coefficients using unpacked array
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i < 256; i++) begin
                w[i] <= '0;
            end
        end else begin
            for (int i = 0; i < 256; i++) begin
//            z_bits[(j * W_WIDTH) +: W_WIDTH] = w[255 - j];
                w[i] <= v[(i)*bitlen_b +: bitlen_b];
            end
        end
    end
endmodule