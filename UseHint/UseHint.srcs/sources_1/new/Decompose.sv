`timescale 1ns / 1ps
import Dilithium_pkg::*;

module Decompose #(
    parameter int width = 32,
    parameter int r1_width = 32,
    parameter int r0_width = 32
)(
    input logic [width-1:0] r,       
    output logic signed [r1_width-1:0] r1,     
    output logic signed [r0_width-1:0] r0      
);

    logic signed [width-1:0] r_prime;  
    logic signed [width-1:0] two_gamma;  

    assign two_gamma = 2 * gamma2;

    always_comb begin
        r_prime = r % q;       
 
        r0 = (two_gamma / 2 - r_prime) % two_gamma;
        if (r0 < 0) begin
            r0 = r0 + two_gamma;  
        end
        r0 = -r0 + (two_gamma / 2); 

        if (r_prime - r0 == q - 1) begin
            r0 = r0 - 1;
            r1 = 0;
        end else begin
            r1 = (r_prime - r0) / two_gamma;
        end
    end

endmodule

