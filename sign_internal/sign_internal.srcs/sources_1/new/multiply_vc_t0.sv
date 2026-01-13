`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2025 06:02:33 AM
// Design Name: 
// Module Name: multiply_vc_s1
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
module multiply_vc_t0(
    input logic signed [31:0] v_c_hat [0:255],
    input logic signed [31:0] s2_ntt [0:Dilithium_pkg::k-1][0:255],
    output logic signed [63:0] v_c_hat_s2_ntt [0:Dilithium_pkg::k-1][0:255],
    output logic mul_done,
    input clk,rst
    );
//    logic [2:0] i;
    logic [8:0] countA,ntt_count;
    
    logic [2:0] i;        // outer index for s1_ntt polynomials (l ? 8)
    logic [8:0] j;
    
    logic rst_ntt,nttdone,ntt_disabler,done;
    logic signed [63:0] w [0:255];
    logic signed [63:0] w_hat [0:255];
    logic [120:0]checking,checking2;
    
    
    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
           i <= 0;
           countA <= 0;
           done <= 0;   
           ntt_count <= 0;  
           j <= 0;
           mul_done <= 0;
//           done <= 0;                  
        end else begin
                    if (~done) begin                  
                       v_c_hat_s2_ntt[i][j] <= v_c_hat[j] * s2_ntt[i][j];
                       if (j == 255) begin
                           j <= 0;
                           if (i == Dilithium_pkg::k - 1) begin
                               done <= 1;
                           end else begin
                               i <= i + 1;
                           end
                       end else begin
                           j <= j + 1;
                       end 
                    end   
//            v_c_hat_s1_ntt[i][countA] <= v_c_hat[i]*s1_ntt[i][countA];
//            if (done && rst_ntt === 'x) begin
//                w_hat <= v_c_hat_s1_ntt[ntt_count];
//                rst_ntt <= 1;                
//            end
//            if (rst_ntt) begin
//                rst_ntt <= 0;
//            end
            
//            if ( nttdone && ~rst_ntt) begin
//                v_c_hat_s1_ntt[ntt_count] <= w;
//                rst_ntt <= rst_ntt || nttdone;                
//            end else 
                        
//            if ( nttdone && rst_ntt ) begin
////                v_c_hat_s1_ntt[ntt_count] <= w_hat;
//                w_hat <= v_c_hat_s1_ntt[ntt_count];
//                ntt_count += 1;                
//            end 
            if (done) begin
                if (done && rst_ntt === 'x) begin
                    rst_ntt <= 1;                         
                end
                if (rst_ntt) begin
                    rst_ntt <= 0;                    
                end
                if (nttdone) begin                                        
                    rst_ntt <= 1;
                end
                
                if (nttdone && rst_ntt) begin
                    ntt_count <= ntt_count + 1;    
                end
                
                
                
                if (nttdone && ~rst_ntt) begin
                    w_hat <= v_c_hat_s2_ntt[ntt_count];
                end
                
//                if (nttdone && ~rst_ntt) begin
//                    w_hat <= v_c_hat_s1_ntt[ntt_count];
//                end
//                if (ntt_count == l-1) begin
                    
                
//                if (rst_ntt || nttdone) begin
//                    w_hat <= v_c_hat_s1_ntt[ntt_count];
//                end
             end
                     
        end
    end
    
    always_comb begin
        if (nttdone && ~rst_ntt && ntt_count >= 1) begin
            v_c_hat_s2_ntt[ntt_count-1] = w;
        end
        if (ntt_count == k+1) begin
//                                rst_ntt = 'x;
                                ntt_count = 'x;
                                done = 'x;
                                mul_done = 1;               
                            end
    end
    
    
    NTT_INV #(.WIDTH(64)) NTT (
            .clk(clk),
            .rst(rst_ntt),
            .w(w),
            .w_hat(w_hat),
            .done(nttdone),
            .disabler(ntt_disabler)
    );    
endmodule
