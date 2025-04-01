`timescale 1ns / 1ps

import Dilithium_pkg::*;
parameter int bl = 32*(1+$clog2(gamma1-1));
parameter int cl = lambda/4;
module sigdecode(
    input logic [(((lambda/4)+(l*32*(1+$clog2(gamma1-1)))+omega+k)*8)-1:0] sigma,
    input logic clk, rst,
    output logic [255:0] h [k-1:0],
    output logic [(cl*8)-1:0] c_tilde,
    output logic [31:0] z [0:l-1] [0:255]   
    );       
    
    logic [7:0] count;
    logic [31:0] offset;
    logic [5119:0] xi;
    logic [((flog2((gamma1-1) + gamma1 + 1)) * 256) - 1:0] v;
    logic [31:0] w[0:255];
    logic [((omega+k)*8)-1:0] y;
    logic valid,hint_rst;
        
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
            .rst(hint_rst),
            .y(y),
            .h(h),
            .valid(valid)
        );

          
    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            count <= 0;  
            offset <= cl;  
        end else begin
            if (count == l-1) begin
                hint_rst <= 1;
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
