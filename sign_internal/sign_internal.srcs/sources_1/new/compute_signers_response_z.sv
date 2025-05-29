`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2025 11:27:15 PM
// Design Name: 
// Module Name: compute_signers_response_z
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
function automatic signed [31:0] compute_remainder3(input signed [63:0] x, input signed [23:0] N);
    begin
        compute_remainder3 = x - ((x / N) * N);
        if (compute_remainder3 < 0)
            compute_remainder3 = compute_remainder3 + N;
    end
endfunction
import Dilithium_pkg::*;

module compute_signers_response_z(
    input logic signed [31:0] y [0:l-1] [0:255],
    input logic signed [63:0] cs1 [0:l-1][0:255],
    output logic signed [31:0] z [0:l-1][0:255],
    input logic rst, clk,
    output logic done    
    );
    
    logic [7:0] i_count;
        logic [7:0] j_count;
        logic processing;
    
    always_ff @(posedge clk or posedge rst) begin
            if (rst) begin
                i_count <= 0;
                j_count <= 0;
                done <= 0;
                processing <= 1;
            end else if (processing) begin
                // Perform modular addition
                z[i_count][j_count] <= compute_remainder3((y[i_count][j_count] + cs1[i_count][j_count]),q);
    
                // Inner counter increment
                if (j_count == 8'd255) begin
                    j_count <= 0;
                    // Outer counter increment
                    if (i_count == (l - 1)) begin
                        i_count <= 0;
                        processing <= 0;
                        done <= 1;
                    end else begin
                        i_count <= i_count + 1;
                    end
                end else begin
                    j_count <= j_count + 1;
                end
            end
        end
    
endmodule
