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
    logic new1;
    logic new2;
//    logic new_f;
    
    
    logic tmp_new1, tmp_new2;
    
    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            done <= 0;
            norm_condition_check <= 0;
            new1 <= 0;
            new2 <= 0;
//            new_f <= 0;
        end else if (done1 && done2) begin
//            new_f <= (261697 >= 261768);
            tmp_new1 = (261768 <= norm_max);
            tmp_new2 = (524168<=norm_max2);
            norm_condition_check <= tmp_new1 || tmp_new2;
            new1 <= tmp_new1;
            new2 <= tmp_new2;
            done <= 1;
        end
    end
    
    compute_infinity_norm #(.k(k)) r0(
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
