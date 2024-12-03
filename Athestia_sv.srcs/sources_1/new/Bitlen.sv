`timescale 1ns / 1ps

module Bitlen #(
    parameter int MAX_WIDTH = 5  // Maximum width of the integer x
)(
    input  logic [MAX_WIDTH-1:0] x,  // Input integer
    output logic [$clog2(MAX_WIDTH):0] bit_length // Output bit length
);

    always_comb begin
        bit_length = 0;
        for (int i = MAX_WIDTH-1; i >= 0; i--) begin
            if (x[i]) begin
                bit_length = i + 1; // Bit length is index + 1
                break;
            end
        end
    end
endmodule

