`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2025 05:58:07
// Design Name: 
// Module Name: ringOscillatorTop
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


module ringOscillatorTop (
    input logic clk,               // System clock (for sampling)
    input logic rst,               // Active-high reset
    output logic rand_xor           // XORed single-bit output
);
    // 8 Ring Oscillators (each with a unique length)
    logic ro_out[7:0]; 

    // Instantiate 8 different ring oscillators with clk and rst
    ring_oscillator #(3) ro1 (.clk(clk), .rst(rst), .out(ro_out[0]));
    ring_oscillator #(5) ro2 (.clk(clk), .rst(rst), .out(ro_out[1]));
    ring_oscillator #(7) ro3 (.clk(clk), .rst(rst), .out(ro_out[2]));
    ring_oscillator #(9) ro4 (.clk(clk), .rst(rst), .out(ro_out[3]));
    ring_oscillator #(11) ro5 (.clk(clk), .rst(rst), .out(ro_out[4]));
    ring_oscillator #(13) ro6 (.clk(clk), .rst(rst), .out(ro_out[5]));
    ring_oscillator #(15) ro7 (.clk(clk), .rst(rst), .out(ro_out[6]));
    ring_oscillator #(17) ro8 (.clk(clk), .rst(rst), .out(ro_out[7]));

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            rand_xor <= 1'b0;
        end else begin

            // XORed output for randomness
            rand_xor <= ro_out[0] ^ ro_out[1] ^ ro_out[2] ^ ro_out[3] ^ 
                        ro_out[4] ^ ro_out[5] ^ ro_out[6] ^ ro_out[7];
        end
    end
endmodule
