`timescale 1ns / 1ps

module SimpleBitPack #(
    parameter int W_WIDTH = 10  // Width of the coefficients in w
//    parameter int B_WIDTH = 8   // Width of the integer b
)(
    input logic [W_WIDTH-1:0] w [255:0],  // Input array w of 256 elements
//    input logic [B_WIDTH-1:0] b,          // Input integer b
    output logic [(256 * W_WIDTH) - 1:0] z  // Output packed bitstream z
);
    logic [(256 * W_WIDTH) - 1:0] z_bits;  // Final packed bits array

    always_comb begin
        z_bits = '0;  // Initialize the final bit array to zero
        
//        for (int j = 0; j < 256; j++) begin
//            $display("w[%0d] = %0d", j, w[j]);
//        end

        for (int j = 0; j < 256; j++) begin
           z_bits[(j * W_WIDTH) +: W_WIDTH] = w[j];
//           z_bits[(j * W_WIDTH) +: W_WIDTH] = w[255 - j];
        end
    end
    assign z = z_bits;
    
endmodule
