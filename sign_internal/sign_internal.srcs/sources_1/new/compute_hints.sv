`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2025 02:06:29 AM
// Design Name: 
// Module Name: compute_hints
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

module compute_hints(
    input logic signed [63:0] int0_out [0:Dilithium_pkg::k-1][0:255],
    input logic signed[63:0] w_out  [0:Dilithium_pkg::k-1][0:255],
    input logic signed [63:0] ins2_out [0:Dilithium_pkg::k-1][0:255],
    input logic clk, rst,
    output logic done,
    output logic signed h [0:Dilithium_pkg::k-1][0:255] 
    );
    logic [8:0] i; // supports up to 512
        logic [8:0] j;
        logic processing;
        logic signed [63:0] ct0_val;
                        logic signed [63:0] w_val;
                        logic signed [63:0] cs2_val;
            
                        logic signed [63:0] sub_result;
                        logic signed [63:0] r;
                        logic signed [63:0] x;

                        logic [31:0] decompose_r1,decompose_r1_2,decompose_r_2;
                            logic [31:0] decompose_r;
    
        always_ff @(posedge clk or posedge rst) begin
            if (rst) begin
                i <= 0;
                j <= 0;
                done <= 0;
                processing <= 1;
                for (int m = 0; m < k; m = m + 1) begin
                                for (int n = 0; n < 256; n = n + 1) begin          
                                    h[m][n] <= 0;
                                end
                            end
                ct0_val <= 0;    
                w_val <= 0;
                cs2_val <= 0;
                sub_result <= 0;
                r <= 0;     
                x <= 0;                                                                 
            end else if (processing) begin
                // Perform modular arithmetic:
                ct0_val = int0_out[i][j];
                w_val   = w_out[i][j];
                cs2_val = ins2_out[i][j];
    
                sub_result = w_val - cs2_val;
                if (sub_result < 0)
                    sub_result = sub_result + q;
    
                r = sub_result + ct0_val;
                if (r >= q)
                    r = r - q;
                x = -ct0_val;
                if (x < q)
                    x = x + q;
                    
                decompose_r <= r;
                decompose_r_2 <= r+x;                                        
    
                h[i][j-1] <= decompose_r1 != decompose_r1_2;
    
                // Increment j, then i
                if (j == 255) begin
                    j <= 0;
                    if (i == k-1) begin
                        i <= 0;
                        processing <= 0;
                        done <= 1;
                    end else begin
                        i <= i + 1;
                    end
                end else begin
                    j <= j + 1;
                end
            end
        end
    Decompose #(
                    .width(32)             
                ) highBits (
                    .r(decompose_r),
                    .r1(decompose_r1)
                );

Decompose #(
                    .width(32)             
                ) highBits2 (
                    .r(decompose_r_2),
                    .r1(decompose_r1_2)
                );
    
endmodule
