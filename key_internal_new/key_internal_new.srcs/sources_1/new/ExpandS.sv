`timescale 1ns / 1ps

import Dilithium_pkg::*;

module ExpandS(
    input logic [511:0] rho,
    input logic clk,rst,start,
    output logic signed [($clog2(eta)+2):0] s1 [0:l-1] [0:255],
    output logic signed [($clog2(eta)+2):0] s2 [0:k-1] [0:255],
    output logic done
    );
    logic signed [($clog2(eta)+2):0] s1_temp [0:l-1] [0:255];
    logic signed [($clog2(eta)+2):0] s2_temp [0:k-1] [0:255];
    logic [3:0] count,count2;
    logic [527:0] rho_p;
    logic [4096:0] shakeOut;
    logic signed [($clog2(eta)+2):0] A [0:255];
    logic done1,local_rst,next;
        RejBoundedPoly uut (
            .clk(clk),
            .rst(local_rst),
            .start(start),
            .rho(rho_p),
            .A(A),
            .done(done1)
        );
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            done <= 0;
            count <= 0;
            rho_p <= {16'd0,rho};
            local_rst <= rst;
            count2 <= 0;
        end else if (start) begin
            
            if (done1) begin
                local_rst <= done1;
                if (count == l-1) begin
                    s1_temp[l-1] <= A;
                    count <= 'x;
                    count2 <= 0;
                    rho_p <= {16'd0+l,rho};
                    next <= 1;
                end else begin
                    rho_p <= {count+1,rho};
                    s1_temp[count] <= A;
                    count <= count + 1;
                end
                if (next) begin
                   if (count2 == k-1) begin
                       s2_temp[k-1] <= A;
                       count2 <= 'x;
                       count <= 'x;
                       rho_p <= 'x;
                       done <= 1;
                   end else begin
                       rho_p <= {count2+1+l,rho};
                       s2_temp[count2] <= A;
                       count2 <= count2 + 1;
                   end 
                end
                
            end else begin
                local_rst <= rst; 
            end
        end
    end
    
    assign s1 = s1_temp;
    assign s2 = s2_temp;
endmodule
