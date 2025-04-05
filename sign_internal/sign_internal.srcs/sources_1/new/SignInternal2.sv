`timescale 1ns / 1ps
import Dilithium_pkg::*;

function automatic logic [23:0] extend_bits(
    input logic [13:0] value,  // Handles both 4-bit and 14-bit inputs
    input bit is_signed
);
    logic [23:0] extended_value;
    extended_value[13:0]  = value;  // Assign directly (works for both cases)
    extended_value[23:14] = is_signed ? {10{value[13]}} : 10'b0; // Sign or zero extension
    return extended_value;
endfunction
module sign_internal2
#(
    parameter msg_len = 32,
    parameter ctx_len = 77,
    parameter rnd_len = 32)

(
    input  logic [8*(32 + 32 + 64 + 32 * (((Dilithium_pkg::l + Dilithium_pkg::k) * ($clog2(2 * Dilithium_pkg::eta) + 1)) 
                                        + (Dilithium_pkg::d * Dilithium_pkg::k))) - 1 : 0] sk,
    input  logic [(16+(ctx_len*8)+(msg_len*8))-1:0] msg,
    input  logic [(rnd_len*8)-1:0] rnd,                                                                           
    input  clk,
    input  rst      
);    
    logic skdone, initiator, nttdone, rst_ntt, ntt_disabler, s1_ntt_done, s2_ntt_done,shakeRst2,shakeDone2;
    logic [3:0] counts1;
    logic [4:0] count_rst;
    logic signed [22:0] w [0:255];
    logic signed [31:0] w_hat [0:255];
    logic signed [3:0] s1 [0:Dilithium_pkg::l-1][0:255];
    logic signed [31:0] s1_ntt [0:Dilithium_pkg::l-1][0:255];
    logic signed [31:0] s2_ntt [0:Dilithium_pkg::k-1][0:255];
    logic signed [31:0] t0_ntt [0:Dilithium_pkg::k-1][0:255];
    logic signed [3:0] s2 [0:Dilithium_pkg::k-1][0:255];
    logic signed [13:0] t0 [0:Dilithium_pkg::k-1][0:255];
    logic [255:0] rho;
    logic [31:0] A [0:k-1] [0:l-1] [0:255];
    logic [511:0] tr;
    logic [255:0] K;
    logic [(ctx_len*8)+(msg_len*8)+527:0] shakeIn;
    logic [767+(rnd_len*8):0] shakeIn2;

    skDecode skDecode (
        .sk(sk),
        .rho(rho),
        .K(K),
        .tr(tr),
        .clk(clk),
        .rst(rst),
        .s1(s1),
        .s2(s2),
        .t0(t0),
        .done(skdone)
    );
    
        logic expandA_rst;


    NTT #(.width(23)) NTT (
        .clk(clk),
        .rst(rst_ntt),
        .w(w),
        .w_hat(w_hat),
        .done(nttdone),
        .disabler(ntt_disabler)
    );
    always_ff @(posedge clk)begin
            if (skdone && expandA_rst === 'x) begin
                expandA_rst <= 1;        
            end
            if (expandA_rst) begin
                expandA_rst <= 0;
                shakeIn <= {msg,tr};
            end
        end
    logic [255:0] swapOut;
//    SwapNibbles #(256) swap (
//                .in(rho),
//                .out(swapOut)
//            );
    
    
    ExpandA expandA (
                .clk(clk),
                .rst(expandA_rst),
                .start(skdone),
                .rho(rho),
                .A(A)
            );
    
    logic [511:0] shakeOut,shakeOut2;
    logic shakeDone,shakeStart;
                   
    always_ff @(posedge clk) begin
        if (rst) begin
            count_rst   <= 0;
            initiator   <= 0;
            counts1     <= 0;   
            s1_ntt_done <= 0;
            s2_ntt_done <= 0;    
        end else begin
            rst_ntt <= initiator || nttdone;                                                   
            if (skdone && counts1 < Dilithium_pkg::l) begin
                count_rst <= count_rst + 1;
                initiator <= 1;                   
                for (int i = 0; i < 256; i++) begin
                    w[i] <= extend_bits(s1[counts1][i], 1);
                end
            end

            if (s1_ntt_done && counts1 < Dilithium_pkg::k) begin
                count_rst <= count_rst + 1;
                initiator <= 1;                   
                for (int i = 0; i < 256; i++) begin
                    w[i] <= extend_bits(s2[counts1][i], 1);
                end
            end 

            if (s2_ntt_done && counts1 < Dilithium_pkg::k) begin
                count_rst <= count_rst + 1;
                initiator <= 1;                   
                for (int i = 0; i < 256; i++) begin
                    w[i] <= extend_bits(t0[counts1][i], 1);
                end
            end

            if (count_rst == 2) begin
                initiator <= 0;
                count_rst <= 'x;
            end else if (count_rst === 'x) begin
                initiator <= 0;   
            end

            if (nttdone && counts1 < Dilithium_pkg::l && ~rst_ntt && ~s1_ntt_done && ~s2_ntt_done) begin
                counts1       <= counts1 + 1;
                s1_ntt[counts1] <= w_hat;                                
            end 

            if (nttdone && counts1 < Dilithium_pkg::k && ~rst_ntt && s1_ntt_done && ~s2_ntt_done) begin
                counts1       <= counts1 + 1;
                s2_ntt[counts1] <= w_hat;                                
            end

            if (nttdone && counts1 < Dilithium_pkg::k && ~rst_ntt && s1_ntt_done && s2_ntt_done) begin
                counts1       <= counts1 + 1;
                t0_ntt[counts1] <= w_hat; 
            end             

            if (counts1 == Dilithium_pkg::k && s1_ntt_done) begin
                s2_ntt_done <= 1;
                counts1     <= 0; 
                count_rst   <= 0;
            end 

            if (counts1 == Dilithium_pkg::k && s2_ntt_done) begin
                initiator    <= 'x; 
                ntt_disabler <= 1;
            end

            if (counts1 == Dilithium_pkg::l && ~s1_ntt_done) begin
                s1_ntt_done <= 1; 
                counts1     <= 0; 
                count_rst   <= 0;            
            end
            
            if (shakeDone && shakeRst2 === 'x) begin   
                            shakeRst2 <= 1;                
                        end
                        if (shakeRst2) begin
                            shakeRst2 <= 0;
                            shakeIn2 <= {shakeOut,rnd,K}; 
                        end
        end
    end
    
sponge #(
                .msg_len((ctx_len*8)+(msg_len*8)+532),
                .d_len(512),
                .capacity(512)
            ) compute_mu_shake256 (
                .clk(clk),
                .reset(expandA_rst),
                .start(1'b1),
                .message({4'hF,shakeIn}),
                .z(shakeOut),
                .done(shakeDone)
            );
sponge #(
                        .msg_len(772+(rnd_len*8)),
                        .d_len(512),
                        .capacity(512)
                    ) rho_double_prime (
                        .clk(clk),
                        .reset(shakeRst2),
                        .start(1'b1),
                        .message({4'hF,shakeIn2}),
                        .z(shakeOut2),
                        .done(shakeDone2)
                    );
        
endmodule