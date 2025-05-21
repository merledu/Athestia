`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2025 01:43:14 AM
// Design Name: 
// Module Name: norm_if
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

import Dilithium_pkg::*;

module norm_if(
    input logic signed [31:0] vector [0:k-1][0:255],
    input logic signed [31:0] vector2 [0:l-1][0:255],
    input logic clk,
    input logic rst,
    output logic done,
    output logic norm_condition_check
    );
    
    logic [31:0] norm_max;
    logic [31:0] norm_max2;
    logic done1,done2;
    
    
    always_ff @(posedge clk or negedge rst) begin
        if (done1 && done2) begin
            norm_condition_check <= (norm_max >= (gamma1 - beta)) || (norm_max2 >= (gamma2-beta));
            done <= 1;
        end
    end
    
    compute_infinity_norm  r0(
       .clk(clk),
       .rst(rst),
       .vector(vector),
       .max_value(norm_max),
       .done(done1)
   );
    
    compute_infinity_norm #(.k(l)) z (
       .clk(clk),
       .rst(rst),
       .vector(vector2),
       .max_value(norm_max2),
       .done(done2)
   );
endmodule
