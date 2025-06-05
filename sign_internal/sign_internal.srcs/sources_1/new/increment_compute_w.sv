`timescale 1ns / 1ps
import Dilithium_pkg::*;

module increment_compute_w(
    input logic signed [31:0] Y [0:Dilithium_pkg::l-1][0:255],
    input logic [31:0] A [0:k-1][0:l-1][0:255],
    output logic signed [63:0] W [0:Dilithium_pkg::k-1][0:255],
    input logic clk,rst,
    output logic final_done    
    );
    
    logic [31:0] i, j;
    logic [31:0] countA,count;
    logic nttinv_rst,nttinv_done,nttinv_done_d,inv_disabler,done;
    logic signed [63:0] nttinv_w [0:255];
    logic signed [63:0] nttinv_w_hat [0:255];
    
    
    
    NTT_INV #(.WIDTH(64)) NTT_INV (
                 .clk(clk),
                 .rst(nttinv_rst),
                 .w(nttinv_w),
                 .w_hat(nttinv_w_hat),
                 .disabler(inv_disabler),
                 .done(nttinv_done)
        );      
        
    
    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            i <= 0;
            j <= 0;
            countA <= 0;
            count <= 0;
            done <= 0;
            final_done <= 0;
            for (int m = 0; m < k; m = m + 1) begin
                 for (int n = 0; n < 256; n = n + 1) begin          
                      W[m][n] <= 32'd0;
                end
            end
        end else begin
            if (!done) begin
                   W[i][countA-1] <= W[i][countA-1] + (A[i][j][countA-1] * Y[j][countA-1]);
                   if (i == 7 && j == 6 && countA == 256) begin
                       i <= 'x;
                       j <= 'x;
                       countA <= 'x;
                       done <= 1;
                   end
                   
                   if (countA < 256) countA <= countA + 1;
                   else begin
                       countA <= 0;
                       
                   if (j < l-1) j <= j + 1;
                   else begin
                       j <= 0;
                       if (i < k-1) i <= i + 1;
                       else i <= 0;
                   end
                   end
             end
             if (done) begin
                nttinv_done_d <= nttinv_done;
                if(nttinv_rst === 'x)begin
                    nttinv_rst <= 1;
                end else if (nttinv_rst) begin
                    nttinv_rst <= 0;
                end
                nttinv_w_hat <= W[count];
                if (nttinv_done && !nttinv_done_d) begin
                    W[count-1] <= nttinv_w;
                    count <= count + 1;
                    nttinv_rst <= nttinv_done;
                end
                if (count == 9) begin
                    final_done <= 1;
                    nttinv_rst <= 'x;
//                    done <= 'x;
                end
             end
         end
    end    
    
endmodule















