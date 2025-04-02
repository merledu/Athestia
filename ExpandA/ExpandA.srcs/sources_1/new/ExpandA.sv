`timescale 1ns / 1ps
function logic [255:0] reverse_nibbles(logic [255:0] input_data);
    logic [255:0] output_data;
    int i;
    
    // Reverse each 4-bit nibble
    for (i = 0; i < 256; i += 4) begin
        unique case (input_data[i +: 4])  // Reverse bits in each nibble
            4'h0: output_data[i +: 4] = 4'h0;
            4'h1: output_data[i +: 4] = 4'h8;
            4'h2: output_data[i +: 4] = 4'h4;
            4'h3: output_data[i +: 4] = 4'hC;
            4'h4: output_data[i +: 4] = 4'h2;
            4'h5: output_data[i +: 4] = 4'hA;
            4'h6: output_data[i +: 4] = 4'h6;
            4'h7: output_data[i +: 4] = 4'hE;
            4'h8: output_data[i +: 4] = 4'h1;
            4'h9: output_data[i +: 4] = 4'h9;
            4'hA: output_data[i +: 4] = 4'h5;
            4'hB: output_data[i +: 4] = 4'hD;
            4'hC: output_data[i +: 4] = 4'h3;
            4'hD: output_data[i +: 4] = 4'hB;
            4'hE: output_data[i +: 4] = 4'h7;
            4'hF: output_data[i +: 4] = 4'hF;
        endcase
    end
    
    return output_data;
endfunction


import Dilithium_pkg::*;
module ExpandA(
    input logic [255:0] rho,
    input logic clk,rst,start,
    output logic [31:0] A [0:k-1] [0:l-1] [0:255],
    output logic done
    );
    
    logic [7:0] r1,r2,s1,s2;
    logic [271:0] rho_concate1,rho_concate2;
    logic [31:0] A_poly1 [0:255];
    logic [31:0] A_poly2 [0:255];
    logic done_poly1,done_poly2,local_rst1,local_rst2;
    logic [255:0] rho_2;
    
    
      RejNttPoly RejNttPoly1 (
           .clk(clk),
           .rst(local_rst1 || rst),
           .start(start),
           .rho(rho_concate1),
           .A(A_poly1),
           .done(done_poly1)
       );
     
     RejNttPoly RejNttPoly2 (
           .clk(clk),
           .rst(local_rst2 || rst),
           .start(start),
           .rho(rho_concate2),
           .A(A_poly2),
           .done(done_poly2 )
       );
    
    always_ff @(posedge clk or negedge rst) begin
        
        if (rst) begin
            r1 <= 0;
            r2 <= k/2;
            s1 <= 0;
            s2 <= 0;
//            rho_concate1 = {r1,s1,rho};
            local_rst1 <= 0;
        end else begin
//            if (done_poly1)begin
                local_rst1 <= done_poly1;
                local_rst2 <= done_poly2;
//            end
            if (s1 < l - 1 && done_poly1) begin
                    s1 <= s1 + 1;  
                    
            end else if (r1 < (k / 2) - 1 && done_poly1) begin
                    s1 <= 0;       
                    r1 <= r1 + 1;
            end
            
            if (s2 < l - 1 && done_poly2) begin
                    s2 <= s2 + 1;  
            end else if (r2 < k - 1 && done_poly2) begin
                    s2 <= 0;       
                    r2 <= r2 + 1;
            end
            
        end
        
    end  
    
    always_comb begin
        rho_2=reverse_nibbles(rho);
        rho_concate1 = {r1,s1,rho_2};
        rho_concate2 = {r2,s2,rho_2};
        
        if (done_poly2)begin
            A[r2][s2] = A_poly2;
        end
        if (done_poly1)begin
            A[r1][s1] = A_poly1;
        end
    end  
    
endmodule
