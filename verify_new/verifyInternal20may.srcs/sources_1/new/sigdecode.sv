`timescale 1ns / 1ps

import Dilithium_pkg::*;
parameter int bl = 32*(1+$clog2(gamma1-1));
parameter int cl = lambda/4;
module sigdecode(
    input logic [(((lambda/4)+(l*32*(1+$clog2(gamma1-1)))+omega+k)*8)-1:0] sigma,
    input logic clk, rst, start,
    output logic done, valid,
    output logic  h [0:k-1][0:255],
    output logic [(cl*8)-1:0] c_tilde,
    output logic [31:0] z [0:l-1] [0:255]   
    );       
    
    logic [7:0] count;
    logic [31:0] offset;
    logic [5119:0] xi;
    logic [((flog2((gamma1-1) + gamma1 + 1)) * 256) - 1:0] v;
    logic [31:0] w[0:255];
    logic [((omega+k)*8)-1:0] y;
    logic valid_internal, hint_rst;
        
    BitUnpack #(
        .a(gamma1-1),
        .b(gamma1),
        .w_len(32),
        .b_len(flog2((gamma1-1) + gamma1 + 1)) 
    ) BP1 (
        .v(v),
        .w(w)
    );
    
    HintBitUnpack dut (
            .clk(clk),
            .rst(rst),
            .y(y),
            .h(h),
            .valid(valid_internal)
        );

    assign valid = valid_internal;
          
    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            count <= 0;  
            offset <= cl;  
            done <= 0;
        end else if (start) begin
            if (count == l-1) begin
                hint_rst <= 1;
                done <= 1;
            end
            if (count < l) begin         
                c_tilde <= sigma[0+:cl*8];
                v <= sigma[(offset)*8 +: (bl)*8 + 8];
                count <= count + 1;                
                offset <= offset + bl;
            end else begin
                hint_rst <= 0;
                y = sigma[offset*8+:(omega+k)*8];
            end
        end
    end
    
    always_comb begin
        z[count-1] = w;         
    end
endmodule