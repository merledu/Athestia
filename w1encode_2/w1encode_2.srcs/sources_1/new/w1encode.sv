`timescale 1ns / 1ps
//////////////////////////////////////////

//module w1encode #(
//    parameter int k = 8,
//    parameter int q = 8380417,
//    parameter int gamma = (q-1)/32,
//    parameter int widht = 4//((q-1)/(2*gamma))-1
//) (
//    input logic clk,
//    input logic reset,
//    input logic start,
//    input logic [widht-1:0] w1[0:k-1][0:255],  // Original input array
//    output logic done,
//    output logic [256*(k-1)*widht-1:0] w1_hat
//);
module w1encode #(
    parameter int k = 8,
    parameter int q = 8380417,
    parameter int gamma = (q-1)/32,
    parameter int widht = 4 // Corrected typo
) (
    input logic clk,
    input logic reset,
    input logic start,
//    (* keep = "true" *) input logic [widht-1:0] w1[0:k-1][0:255],  // Corrected parameter name
(* keep = "true" *) input logic [widht-1:0] w1_flat[0:(k*256)-1],

    output logic done,
    output logic [256*k*widht-1:0] w1_hat  // Width calculation matches testbench
);

    // Internal signals
    //(* HIERARCHY = "true" *)logic [widht-1:0] w[0:255]; // Local registers to hold w1 slice
    logic [widht-1:0] w1[0:k-1][0:255];
    
    genvar i, j;
    generate
      for (i = 0; i < k; i++) begin
        for (j = 0; j < 256; j++) begin
          assign w1[i][j] = w1_flat[(i * 256) + j];
        end
      end
    endgenerate

    logic [widht-1:0] w[0:255];
    //logic [(256 * widht) - 1:0] z;
    logic [256*widht-1:0] z;
    logic [3:0] counter; // Counter for 8 iterations
    logic [31:0] start_idx;

    // Instantiate SimpleBitPack
    SimpleBitPack #(.W_WIDTH(widht)) uut (
        .w(w),
        .z(z)
    );

    // Sequential logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset internal signals
            counter <= 0;
            start_idx <= 0;
            done <= 0;
            w1_hat <= '0;
            //w <= '0;
            for (int i = 0; i < 256; i++) begin
                        w[i] <= '0;  // Reset all elements of w
                    end
        end else  begin
            // Avoid directly accessing w1 array, use w as a register slice
            if (start && !done) begin
            //w <= w1[counter];  // Only copy the slice of w1 to w register
            for (int i = 0; i < 256; i++) begin
                        w[i] <= w1[counter][i];
                    end
            // Write z to the corresponding slice of w1_hat
            w1_hat[start_idx +: 256 * widht] <= z;

            // Increment the counter and index
            counter <= counter + 1;
            if (counter >= 1) begin
                start_idx <= start_idx + (256 * widht);
            end

            // Check for completion
            if (counter == k) begin
                done <= 1;
            end
            end
        end
    end

endmodule

