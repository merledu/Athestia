<<<<<<< HEAD
import Dilithium_pkg ::*;

module Decompose #(
=======
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2024 05:42:15 PM
// Design Name: 
// Module Name: decompose
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


module Decompose #(
    parameter int Q = 8380417,        
    parameter int GAMMA = (Q-1)/32,
>>>>>>> da95f738e6c5f8062537e0c1ec368a7abc930a7a
    parameter int width = 32,
    parameter int r1_width=32,
    parameter int r0_width=32
)(
    input logic [width-1:0] r,       
<<<<<<< HEAD
    output logic unsigned [r1_width-1:0] r1,     
    output logic unsigned [r0_width-1:0] r0      
);

    logic unsigned [width-1:0] r_prime;  
    logic unsigned [width-1:0] two_gamma;
=======
    output logic signed [r1_width-1:0] r1,     
    output logic signed [r0_width-1:0] r0      
);

    logic signed [width-1:0] r_prime;  
    logic signed [width-1:0] two_gamma;
>>>>>>> da95f738e6c5f8062537e0c1ec368a7abc930a7a

    assign two_gamma = 2 * gamma2;

    always_comb begin
        
<<<<<<< HEAD
        r_prime = r % q;
        r0 = (r % q) % two_gamma;

        if (r_prime - r0 == q - 1) begin
=======
        r_prime = r % Q;
        r0 = (r % Q) % two_gamma;

        if (r_prime - r0 == Q - 1) begin
>>>>>>> da95f738e6c5f8062537e0c1ec368a7abc930a7a
            r0 = r0 - two_gamma;
            r1 = 0;
        end else begin
            r1 = (r_prime - r0) / two_gamma;
        end
    end

<<<<<<< HEAD
endmodule
=======
endmodule

>>>>>>> da95f738e6c5f8062537e0c1ec368a7abc930a7a
