`timescale 1ns / 1ps
import Dilithium_pkg::*;

module key_internal_2(
    input logic clk, rst,
    input logic [255:0] zeta,
    output logic [1023:0] shakeOut
);

    logic [255:0] swapOut;
    SwapNibbles #(256) swap (
        .in(zeta),
        .out(swapOut)
    );
    
    

    logic shakeDone, shakeStart;
    logic [271:0] shakeIn;
    logic [31:0] A [0:k-1] [0:l-1] [0:255];
    logic [3:0] count;
    logic [3:0] ntt_count; 
    sponge #(
                .msg_len(276),
                .d_len(1024),
                .capacity(512)
            ) shake256 (
                .clk(clk),
                .reset(rst),
                .start(1'b1),
                .message({4'b1111, shakeIn}),
                .z(shakeOut),
                .done(shakeDone)
            );
    always_ff @(posedge clk or posedge rst) begin
            if (rst) begin
                shakeIn <= 272'd0; 
            end else begin
                shakeIn <= {l[7:0], k[7:0], swapOut}; 
        end
    
        
        
        
endmodule