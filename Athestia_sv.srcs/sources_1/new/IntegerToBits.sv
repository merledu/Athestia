`timescale 1ns / 1ps

module IntegerToBits #(
    parameter int ALPHA = 8  // Default bit-width, configurable
)(
    input  logic [ALPHA-1:0] x,       // Input integer x of width ALPHA
    output logic [ALPHA-1:0] y        // Output bit array y (little-endian)
);

    always_comb begin
//        for (int i = 0; i < ALPHA; i++) begin
//            y[i] = x[i];  // Extract each bit and place in corresponding index of y
//        end
        y = x;
    end
endmodule