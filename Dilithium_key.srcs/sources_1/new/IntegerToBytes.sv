`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2024 01:40:07 PM
// Design Name: 
// Module Name: IntegerToBytes
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


module IntegerToBytes #(parameter int alpha = 4) ( // Set the length of output byte array
    input      int unsigned x,         // Input non-negative integer x
    output reg [7:0] y[alpha-1:0]      // Output byte string of length alpha
);
    
    int unsigned x_temp;               
    integer i;

    always_comb begin
        x_temp = x;                   
        for (i = 0; i < alpha; i = i + 1) begin
            y[i] = x_temp % 256;       
            x_temp = x_temp / 256;     
        end
    end

endmodule

