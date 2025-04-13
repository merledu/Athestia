`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2025 15:15:43
// Design Name: 
// Module Name: SwapNibbles
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

module SwapNibbles #(parameter WIDTH = 16) (
    input logic [WIDTH-1:0] in,
    output logic [WIDTH-1:0] out
);
    genvar i;
    generate
        for (i = 0; i < WIDTH; i += 8) begin : swap_block
            assign out[i+7:i] = {in[i+3:i], in[i+7:i+4]};
        end
    endgenerate
endmodule