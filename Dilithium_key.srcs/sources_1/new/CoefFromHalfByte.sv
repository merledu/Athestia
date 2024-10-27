`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2024 06:04:47 AM
// Design Name: 
// Module Name: CoefFromHalfByte
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


module CoefFromHalfByte #(parameter int eta = 2) (
    input  logic [3:0] b, 
    output logic [3:0] result 
);
    always_comb begin
        if (eta == 2 && b < 15)
            result = 2 - (b % 5);
        else if (eta == 4 && b < 9)
            result = 4 - b;
        else
            result = 4'b0000;
    end
endmodule
