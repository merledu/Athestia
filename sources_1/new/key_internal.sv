`timescale 1ns / 1ps
import Dilithium_pkg::*;

module key_internal(
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

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            shakeIn <= 272'd0; 
        else
            shakeIn <= {l[7:0], k[7:0], swapOut}; 
    end

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
    
    logic expandA_rst;
    
    always_ff @(posedge clk)begin
        if (shakeDone && expandA_rst === 'x) begin
            expandA_rst <= 1;        
        end
        if (expandA_rst) begin
            expandA_rst <= 0;
            
        end
    end
    
    logic signed [($clog2(eta)+2):0] s1 [0:l-1] [0:255];
    logic signed [($clog2(eta)+2):0] s2 [0:k-1] [0:255];
    
    ExpandA expandA (
            .clk(clk),
            .rst(expandA_rst),
            .start(shakeDone),
            .rho(shakeOut[255:0]),
            .A(A)
        );
    ExpandS dut (
                .clk(clk),
                .rst(expandA_rst),
                .start(shakeDone),
                .rho(512'h903740a9bd6d69c8e640326418378f2aa9b837ccf835599197d940e64d9b1585408edc20608525229c307bcb15ce980577f34d1b309cdccd308a5cf316d24187),
                .s1(s1),
                .s2(s2)
                 );

endmodule
