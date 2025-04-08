`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/22/2024 02:13:02 AM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module tb_w1encode;

    // Parameters
//    parameter int k = 8;
//    parameter int q = 8380417;
//    parameter int gamma = (q-1)/32;
//    parameter int widht = 4;//((q-1)/(2*gamma))-1;

//    // Inputs and Outputs
//    logic clk;
//    logic reset;
//    logic start;
//    logic [widht-1:0] w1[0:k-1][0:255];
//    logic [256*7*widht-1:0] w1_hat;
//    logic done;
// Parameters
    parameter int k = 8;
    parameter int q = 8380417;
    parameter int gamma = (q-1)/32;
    parameter int widht = 4; // Corrected typo

    // Inputs and Outputs
    logic clk;
    logic reset;
    logic start;
  //  logic [widht-1:0] w1[0:k-1][0:255];
//    [widht-1:0] w1[0:k-1][0:255],  // Match module
//logic [256*(k-1)*widht-1:0] w1_hat;      // Match module
    logic done;
    logic [widht-1:0] w1[0:(k*256)-1];
    logic [256*k*widht-1:0] w1_hat;
    
    w1encode #(.k(k), .q(q), .gamma(gamma), .widht(widht)) dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .w1_flat(w1),
        .done(done),
        .w1_hat(w1_hat)
    );
    // Instantiate the DUT
//    w1encode #(.k(k), .q(q), .gamma(gamma), .widht(widht)) dut (
//        .clk(clk),
//        .reset(reset),
//        .start(start),
//        .w1(w1),
//        .done(done),
//        .w1_hat(w1_hat)
//    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Stimulus
    initial begin
        // Initialize inputs
//        for (int i = 0; i < k; i++) begin
//                    for (int j = 0; j < 256; j++) begin
//                        w1[i][j] = $urandom % (2**widht);
//                    end
//                end
for (int i = 0; i < k*256; i++) begin
      w1[i] = i % 256; // Example: Fill with modulo values of 256
    end
        reset = 1;
        start = 0;
        repeat (2) @(posedge clk);
        reset = 0;

        // Initialize w1 with test data
        
//         w1[0][0] = 10;
//           w1[0][1] = 20;
//           w1[0][2] = 30;
//           w1[1][0] = 40;
//           w1[1][1] = 50;
//           w1[1][2] = 60;

        // Start the operation
        @(posedge clk);
        start = 1;
        #100

        // Wait for completion
        wait(done);
        start = 0;

        // Display results
//        $display("w1_hat = %h", w1_hat);

        // End simulation
        $finish;
    end

endmodule
//`timescale 1ns / 1ps

//module tb_w1encode;
//    // Parameters
//    parameter int k = 8;
//    parameter int q = 8380417;
//    parameter int gamma = (q-1)/32;
//    parameter int widht = ((q-1)/(2*gamma))-1;

//    // Inputs and Outputs
//    logic [widht-1:0] w1[0:k-1][0:255];
//    logic [256*8*widht-1:0] w1_hat;

//    // Instantiate the module
//    w1encode #(
//        .k(k),
//        .q(q),
//        .gamma(gamma),
//        .widht(widht)
//    ) uut (
//        .w1(w1),
//        .w1_hat(w1_hat)
//    );

//    // Testbench logic
//    initial begin
//        // Initialize inputs
//        for (int i = 0; i < k; i++) begin
//            for (int j = 0; j < 256; j++) begin
//                w1[i][j] = 0; // Random initialization within range
//            end
//        end
//                 w1[0][0] = 10;
//                   w1[0][1] = 20;
//                   w1[0][2] = 30;
//                   w1[1][0] = 40;
//                   w1[1][1] = 50;
//                   w1[1][2] = 60;
//        // Monitor the outputs
//        #10;
//        $display("w1_hat: %h", w1_hat);

//        // Add additional test cases if needed
//        #10;
//        $finish;
//    end

//endmodule

