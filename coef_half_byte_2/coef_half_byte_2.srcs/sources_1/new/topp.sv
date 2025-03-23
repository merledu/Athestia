`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2024 02:03:07 PM
// Design Name: 
// Module Name: topp
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


module top_three_bytes #(parameter int q = 8380417)(
    input logic btn,
    input logic clk,
    input logic rst,
    output logic led
);
      
    logic [3:0] b;  
    logic [3:0] check = 2;
    logic [3:0] result;

    // Instantiate CoefFromThreeBytes
    CoefFromHalfByte #(.eta(2))uut (
        .b(b),
        .result(result)
    );

    // Assign fixed values to b0, b1, and b2
       assign b = 5;
//    assign b1 = 90;
//    assign b2 = 129;

//    // Sequential logic for LED
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            led <= 1'b0; // Reset LED
        end else if (btn) begin
            if (result == check) begin
                led <= 1'b1;
            end else begin
                led <= 1'b0;
            end
        end
    end
endmodule

