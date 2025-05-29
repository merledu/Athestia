`timescale 1ns / 1ps

import Dilithium_pkg::*;
parameter int bl = 32*(1+$clog2(gamma1-1));
parameter int cl = lambda/4;
module sigdecode(
    input logic [0:(((lambda/4)+(l*32*(1+$clog2(gamma1-1)))+omega+k)*8)-1] sigma,
//    input logic [0:(((lambda/4)+(l*32*(1+$clog2(gamma1-1)))+omega+k)*8)-1] sigma_big_endian,
    input logic clk, rst, start,
    output logic done, valid,
    output logic h [k-1:0][255:0],
    output logic [(cl*8)-1:0] c_tilde,
    output logic [0:31] z [0:l-1] [255:0]   
    );       
    
    function automatic [512:0] reverse_bytes;
      input [512:0] data_in;  // Supports up to 32 bytes
      input integer cl;       // Number of bytes to reverse (max 32)
      integer i;
      begin
        reverse_bytes = 0;
        for (i = 0; i < cl; i = i + 1) begin
          reverse_bytes[i*8 +: 8] = data_in[(cl - 1 - i)*8 +: 8];
        end
      end
    endfunction
    
    
    
    logic [7:0] count;
    logic [31:0] offset;
    logic [5119:0] xi;
    logic [0:((flog2((gamma1-1) + gamma1 + 1)) * 256) - 1] v;
    logic [0:31] w[0:255];
    logic [0:((omega+k)*8)-1] y;
    logic valid_internal, hint_rst,hint_done,bit_unpack_done;
    logic [10:0]check1;
    logic [(cl*8)-1:0] c_tilde_big_endian;
    
    assign check1 = bl;
    
        
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
            .valid(valid_internal),
            .done(hint_done)
        );

    assign valid = valid_internal;
          
    always_ff @(posedge clk or negedge rst) begin
        done  <= hint_done;
        if (rst) begin
            count <= 0;  
            offset <= cl;  
            done <= 0;
        end else if (start) begin
        
            if (count == l-1) begin
                hint_rst <= 1;
                bit_unpack_done <= 1;
            end
            if (count < l) begin         
                c_tilde <= reverse_bytes(sigma[0+:cl*8], cl);// sigma[0+:cl*8];//512'h9820C322AAF6432C358FE43FCFE839A579A3188ED17CBC21C9CFE410AC8ADCB80F0B5C5AB88023225E3BC1FC45AABA386442FC58FCE5B72AA191E9DE6A5183C8 ;//c_tilde_big_endian;// sigma[cl*8:0];
//                for (int i = 0; i < 32; i++) begin
//                     c_tilde[i*8 +: 8] <= sigma[(cl - 1 - i)*8 +: 8];
//            //             c_tilde <= sigma[0+:cl*8]
//                 end
           
                v <= sigma[(offset)*8 +: (bl)*8 ];
                count <= count + 1;                
                offset <= offset + bl;
            end else begin
                hint_rst <= 0;
                y = sigma[offset*8+:(omega+k)*8];
            end
        end
    end
    
//    genvar i;
//    generate
//      for (i = 0; i < cl; i = i + 1) begin
//        assign c_tilde_big_endian[i*8 +: 8] = sigma[(cl-1-i)*8 +: 8];
//      end
//    endgenerate
    
    always_comb begin
        z[count-1] = w;    
//        for (int i = 0; i < 32; i++) begin
//          c_tilde_big_endian[i*8 +: 8] = sigma[(cl - 1 - i)*8 +: 8];
////             c_tilde <= sigma[0+:cl*8]
//        end
             
    end
endmodule
