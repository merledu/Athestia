`timescale 1ns / 1ps
import Dilithium_pkg::*;


module PkEncode (
    input logic clk, reset,
    input logic [255:0] rho,
    input logic [9:0] t1[0:k-1][0:255],
    output logic [20735:0] pk,
    output logic valid
);

    logic [9:0] w[255:0];
    logic [2559:0] packed_out;
    logic [3:0] count;
    logic [31:0] offset;

    // Instantiate the SimpleBitPack module
    SimpleBitPack #(
        .W_WIDTH(10)
    ) pack_t1 (
        .w(w),  
        .z(packed_out)
    );

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            offset <= 256;
            pk <= '0;  // Initialize pk
            pk[255:0] <= rho; // Initialize pk with rho during reset
        end else begin
//            if (count == 0 && offset == 0) begin
//                offset <= 256;
//            end
            if (count < 8) begin
                count <= count + 1;
                offset <= offset + 2560; // Increment by the packed width
                // Update pk with the packed output
                pk[offset +: 2560] <= packed_out;
            end
        end
    end

    always_comb begin
        // Map t1[count] to w
        w = t1[count];
    end

    // Generate valid signal when pk is fully written
    assign valid = (count == 8);
endmodule
