`timescale 1ns / 1ps

module BitsToBytes #(
    parameter int Y = 8               // Length of input bit array y
)(
    input  logic [Y-1:0] y,                               // Input bit array (big-endian)
    output logic [((Y + 7) / 8) * 8 - 1:0] z              // Output byte array
);

    always_comb begin
        z = '0;

        for (int i = 0; i < Y; i++) begin
//            z[((Y - 1 - i) / 8) * 8 +: 8] = z[((Y - 1 - i) / 8) * 8 +: 8] | (y[i] << ((Y - 1 - i) % 8));
            z[(i / 8) * 8 +: 8] = z[(i / 8) * 8 +: 8] | (y[i] << (i % 8)); // No reversal of index for little-endian
            

        end
    end
endmodule

