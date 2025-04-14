`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2024 12:13:56 PM
// Design Name: 
// Module Name: Coefficient_three_bytes
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


module CoefFromThreeBytes (
    input logic [7:0] b0,  
    input logic [7:0] b1,  
    input logic [7:0] b2,  
    input logic [31:0] q, 
    output logic [23:0] coef,  
    output logic valid         
);
    logic [7:0] b2_prime;
    logic [23:0] z;

    always_comb begin
        if (b2 > 8'd127)
            b2_prime = b2 - 8'd128; 
        else
            b2_prime = b2[7:0]; 

        z = (b2_prime << 16) + (b1 << 8) + b0;

 
        if (z < q) begin
            coef = z;
            valid = 1;
        end else begin
            coef = 24'b0;
            valid = 0;
        end
    end
endmodule
