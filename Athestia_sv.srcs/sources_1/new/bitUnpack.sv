`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2024 11:09:31 PM
// Design Name: 
// Module Name: check
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


module BitUnpack #(
    parameter int a = 2,
    parameter int b = 2,
    parameter int b_len = ($clog2(a + b)+1),
    parameter int w_len = 32
    )(
     input logic [(b_len * 256) - 1:0] v,
     output logic [w_len-1:0] w[0:255]
    );
    
    logic [$clog2((b_len * 256)):0] count;

    always_comb begin
        count = 0;
        for (int i = 0; i < 256; i++) begin
            w[i] = (v[count +: b_len]==0)?0:b - v[count +: b_len];
            count += b_len; 
        end
        
    end

endmodule




















