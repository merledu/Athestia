`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2025 07:44:57 PM
// Design Name: 
// Module Name: increment_highbits
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


module increment_highbits(
    input logic signed [63:0] w_in [0:Dilithium_pkg::k-1][0:255],
    output logic signed [3:0] w_out [0:Dilithium_pkg::k-1][0:255],
    input logic clk,rst,
    output logic done
    );
    logic [31:0] i,countA;
    logic [63:0] decompose_r;
    logic [63:0] decompose_r1;
    Decompose #(
            .width(64),
            .r1_width(5)      
        ) HighBits (
            .r(decompose_r),
            .r1(decompose_r1)
        );
    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            i <= 0;
            countA <= 0;
            done <= 0;
        end else begin
                if (countA < 256) begin                
                    decompose_r <= w_in[i][countA];
                end                                                                                                       
                w_out[i][countA-1] <= decompose_r1;
                if (countA == 256) begin                
                    if (i == 7) begin 
                        if (countA == 256) begin
                           countA <= 257;
                           done <= 1;
//                           decompose_w_done <= 1;
                        end           
                    end else begin
                        i <= i + 1;
                        countA <= 0;
                    end
                end else begin
                    countA <= countA + 1;
                end   
        end                     
    end
endmodule














