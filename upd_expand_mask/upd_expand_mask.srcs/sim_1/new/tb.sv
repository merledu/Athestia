`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2025 12:45:28 AM
// Design Name: Expand_mask_tb
// Module Name: Expand_mask_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for the Expand_mask module.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Expand_mask_tb;

  // Inputs
  logic clk;
  logic rst;
  logic [511:0] rho_double_prime;
  logic [31:0] k;
  logic done;

  // Outputs
  logic [31:0] outputt[0:6] [0:255];
  // Instantiate the Expand_mask module
  Expand_mask #(
    .gamma1(52487),
    .cols_l(7)
  ) uut (
    .clk(clk),
    .rst(rst),
    .rho_double_prime(rho_double_prime),
    .k(k),
    .outputt(outputt),
    .done(done)
  );

  // Clock generation
  always #0.1 clk = ~clk;  // Clock period = 10 ns

  // Initial block for simulation
  initial begin
    // Initialize signals
    clk = 0;
    rst = 0;
    rho_double_prime = 512'b0;
    k = 0;

    // Display output for debugging
    $monitor("Time: %t, count: %d, rho_double_prime: %h, k: %d, outputt[0]: %h", $time, uut.count, rho_double_prime, k, outputt[0]);

    // Reset the DUT
    rst = 1;  // Assert reset
    #10;
    rst = 0;  // Deassert reset

    // Apply test vectors
    // Test 1: Apply some initial values
    rho_double_prime = 512'h72696d6172696d6172696d6172696d6172696d6172696d6172696d6172696d6172696d6172696d6172696d6172696d6172696d6172696d6172696d6172696d61;
    k = 3;
    #1500;  // Wait for a few clock cycles

    // Test 2: Change inputs and observe the effect
//    rho_double_prime = 512'hABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890;
//    k = 5;
//    #10;

//    // Test 3: Apply another change to inputs
//    rho_double_prime = 512'hFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210FEDCBA9876543210;
//    k = 7;
//    #10;

//    // Test 4: Apply more inputs and observe for final results
//    rho_double_prime = 512'h00112233445566778899AABBCCDDEEFF00112233445566778899AABBCCDDEEFF;
//    k = 1;
//    #10;

    // Finish the simulation
    $finish;
  end

endmodule
