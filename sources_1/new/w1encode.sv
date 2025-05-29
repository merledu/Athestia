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
    input logic [widht-1:0] w1[0:k-1][0:255],  // Corrected parameter name
    output logic done,
    output logic [256*k*widht-1:0] w1_hat  // Width calculation matches testbench
);
    // Internal signals
    logic [widht-1:0] w[255:0]; // Local registers to hold w1 slice
    logic [(256 * widht) - 1:0] z;
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
        end else if (start && !done) begin
            
            // Avoid directly accessing w1 array, use w as a register slice
            w <= w1[counter];  // Only copy the slice of w1 to w register
            
            // Write z to the corresponding slice of w1_hat
            w1_hat[start_idx +: 256 * widht] <= z;

            // Increment the counter and index
            counter <= counter + 1;
            if (counter >= 1) begin
                start_idx <= start_idx + (256 * widht);
            end

            // Check for completion
            if (counter == k ) begin
                done <= 1;
//                for (int i; i<8; i++)begin
//                $display(w1[0]);
//                end
                //$display(w1);
                //$display(w1_hat);
            end
        end
    end

endmodule
//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 12/21/2024 04:46:36 PM
//// Design Name: 
//// Module Name: w1encode
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module w1encode #(
//    parameter int k = 8,
//    parameter int q = 8380417,
//    parameter int gamma = (q-1)/32,
//    parameter int widht = ((q-1)/(2*gamma))-1
//    ) (
//    input logic [widht-1:0]w1[0:k-1][0:255],
//    output logic [256*8*widht-1:0]w1_hat
//    );

//    logic [widht-1:0] w [255:0];
//    logic [(256 * widht) - 1:0] z;

//    SimpleBitPack  #(.W_WIDTH(widht))
//    uut(
//        .w(w),      
//        .z(z)       );

//    logic [31:0] start, end1;

//    always_comb begin
//        $display(w1);
//        start = 0;
//        end1 = (256 * widht) - 1;

//        for (int i = 0; i < 2; i++) begin
//            w = w1[i];
//            w1_hat[start +: 256 * widht] = z;
//            start = start + 256 * widht;
//        end
//    end

//endmodule