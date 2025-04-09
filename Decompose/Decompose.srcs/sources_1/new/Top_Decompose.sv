`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 18:58:45
// Design Name: 
// Module Name: Top_Decompose
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



module Top_Decompose #(
    parameter int width = 32,  
    parameter int r1_width = 32,
    parameter int r0_width = 32
)(
    input logic clk,
    input logic rst,
    input logic btn,
    output logic led
);

    // Input and Output for Power2round
    logic unsigned [width-1:0] r = 6766760;
    logic unsigned [r1_width-1:0] r1;
    logic signed [r0_width-1:0] r0;

    // Instantiate Power2round with parameters
    Decompose #(
        .width(width),
        .r1_width(r1_width),
        .r0_width(r0_width)
    ) u_power2round (
        .r(r),
        .r1(r1),
        .r0(r0)
    );
    
    always @(posedge clk) begin
        if (rst) begin
            led <= 1'b0;
        end else if (btn) begin
            // Check if t0 is within expected signed range
            if (r1 == 13 && r0 == -42328) begin
                led <= 1'b1;  // Correct output, set LED
            end else begin
                led <= 1'b0;  // Incorrect output, reset LED
            end
        end
    end


endmodule
