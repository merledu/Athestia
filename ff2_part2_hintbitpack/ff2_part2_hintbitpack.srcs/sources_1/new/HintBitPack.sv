`timescale 1ns / 1ps

module HintBitPack #(
    parameter K = 8,
    parameter W = 75,
    parameter COEFF_WIDTH = 256
) (
    input  logic clk,
    input  logic rst,
    input  logic [255:0] h [K-1:0],
    output logic [7:0] y [W + K - 1:0]
);

    logic [7:0] index;
    logic [$clog2(K):0] i;
    logic [$clog2(256):0] j;

always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 83; i++) begin
                y[i] <= 0;
            end
            index <=0;
            i<=0;
            j<=0;
        end else begin

        if (i < K) begin
            if (j < 256) begin
                if (h[i][j] == 1) begin
                    y[index] <= j;
                    index <= index + 1;
                end
                j <= j + 1;
            end else begin
                y[W + i] <= index;
                j <= 0;
                i <= i + 1;
            end
        end
    end
    end

endmodule
