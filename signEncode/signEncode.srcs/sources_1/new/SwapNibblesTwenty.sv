`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2025 16:40:42
// Design Name: 
// Module Name: SwapNibblesTwenty
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

module Swap20Bits #(parameter WIDTH = 35840) ( // WIDTH should equal BP_OUT_BITS*L
    input  logic [WIDTH-1:0] in,
    output logic [WIDTH-1:0] out
);
    localparam CHUNK = 20;              // Each group is 20 bits (5 hex digits)
    localparam NUM_CHUNKS = WIDTH / CHUNK;
    
    genvar i;
    generate
        for(i = 0; i < NUM_CHUNKS; i = i + 1) begin : swap_group
            // Process the i'th 20-bit group.
            // Here the group in 'in' is taken from:
            //   [WIDTH-1 - i*20 : WIDTH-20 - i*20]
            // Within that group, if we label bits 19 down to 0,
            //   nibble4 = bits [19:16]   (MSB nibble)
            //   nibble3 = bits [15:12]
            //   nibble2 = bits [11:8]
            //   nibble1 = bits [7:4]
            //   nibble0 = bits [3:0]     (LSB nibble)
            // We want output = {nibble0, nibble1, nibble2, nibble3, nibble4}.
            assign out[WIDTH-1 - i*CHUNK -: CHUNK] = {
                in[WIDTH-1 - i*CHUNK - 16 -: 4], // nibble0 (LSB of the group)
                in[WIDTH-1 - i*CHUNK - 12 -: 4], // nibble1
                in[WIDTH-1 - i*CHUNK - 8  -: 4], // nibble2 (stays in the middle)
                in[WIDTH-1 - i*CHUNK - 4  -: 4], // nibble3
                in[WIDTH-1 - i*CHUNK      -: 4]  // nibble4 (MSB of the group)
            };
        end
    endgenerate
endmodule
