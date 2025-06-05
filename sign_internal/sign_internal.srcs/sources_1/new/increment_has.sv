`timescale 1ns / 1ps
import Dilithium_pkg::*;

module increment_has(
    input logic [8191:0] encode_hat,
    input logic [511:0] shakeOut,
    output logic [((lambda/4)*8)-1:0] shakeOut3,
    input clk,rst,
    output logic done
    );
    logic f_done;
    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            done <= 0;
        end else begin
            done <= f_done;
        end
    end
    sponge #(
            .msg_len(8708),
            .d_len((lambda/4)*8),
            .capacity(512)
        ) compute_commit_hash (
            .clk(clk),
            .reset(rst),
            .start(1'b1),
            .message({4'hF,encode_hat,shakeOut}),
            .z(shakeOut3),
            .done(f_done)
        );
endmodule
