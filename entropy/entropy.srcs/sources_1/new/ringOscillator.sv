`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2025 05:55:00
// Design Name: 
// Module Name: ringOscillator
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


module ring_oscillator #(parameter int N = 3) (
    input logic rst,clk,       // Active-high reset
//    input logic bin,       // Single-bit input (0 or 1)
    output logic out       // Oscillating output
);
    logic [N-1:0] inv;

    always_ff @(posedge rst or posedge clk) begin
        if (rst)
            inv <= 0; // Initialize all bits to the input value
        else
            inv <= {inv[N-2:0], ~inv[N-1]}; // Shift and invert
    end

    assign out = inv[N-1]; // Output last inverter value
endmodule
