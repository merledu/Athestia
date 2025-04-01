`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2025 08:10:21 PM
// Design Name: 
// Module Name: RejNttPoly
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

module RejNttPoly(
    input clk,rst,start,
    input logic [271:0] rho,
    //input logic [4096:0] shakeOut,
    output logic [31:0] A [0:255],
    output logic done
    );
    
    logic [7:0] b0,b1,b2;
    
    logic [31:0] j;
    logic [31:0] count,count2;
    logic [23:0] z0,coef;
    logic [6500:0] shakeOut;
    logic shakeDone,valid, shakeStart;
    
       sponge #(
        .msg_len(276),
        .d_len(6501),
        .capacity(256)
    ) shake256(
           .clk(clk),
           .reset(rst),
           .start(1'b1),
           .message({4'b1111,rho}),
           .z(shakeOut),
           .done(shakeDone)
    );
    
    CoefFromThreeBytes uut (
            .b0(b0),
            .b1(b1),
            .b2(b2),
            .q(q),
            .coef(coef),
            .valid(valid)
        );
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            z0 <= 'x;
            count2 <= 0;
            done <= 0;
            shakeStart <= 0;
//            shakeDone <= 0;
        end else if (done && shakeDone) begin
            count <= 'x;
            shakeStart <= 1;
        end else if (shakeDone) begin
            z0 <= shakeOut[count+:24];
            count <= count + 24;
            shakeStart <= 1; 
            
        end 
//        else if ((count/24)-1 == 255) begin
//            done <= 1;
//        end
    end
        
    always_comb begin
        if (rst) begin
            b0='x;
            b1='x;
            b2='x;
//            for (int i = 0; i < 256; i++) begin
//                 A[i] = 0;
//            end
        end else begin
            b0={z0[7:4],z0[3:0]};
            b1={z0[15:12],z0[11:8]};
            b2={z0[23:20],z0[19:16]};
            
            if (count2 == 256) begin
                        done = 1;
                    end
//            t1 = (count/24)-1;
//            if (valid) begin
//                A[count2] = coef;
//                count2 += 1;
//            end
        end
    end  
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count2 <= 0;
        end else if (valid) begin
            A[count2] <= coef;
            count2 <= count2 + 1;  // Increment sequentially
        end
    end
     
      
    
    
endmodule
