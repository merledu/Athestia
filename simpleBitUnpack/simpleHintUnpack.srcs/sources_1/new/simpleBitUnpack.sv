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
    output logic [255:0][bitlen_b-1:0] w // Polynomial coefficients using unpacked array
);

    localparam int C = $clog2(bitlen_b); // bitlen b

    // Generate block to assign coefficients
    genvar i;
    generate
        for (i = 0; i < 256; i = i + 1) begin : gen_coeff
            assign w[i] = v[i*C +: C]; // Directly extract bits from v
        end
    endgenerate
endmodule

//note used packed array for optimization of code because packed array is complete string in bytes form
//all bits packed in one string 