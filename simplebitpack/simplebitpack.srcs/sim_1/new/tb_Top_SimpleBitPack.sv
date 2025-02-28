`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2025 21:56:42
// Design Name: 
// Module Name: tb_Top_SimpleBitPack
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


module tb_Top_SimpleBitPack;
    parameter int W_WIDTH = 10;  // Width of the coefficients in w
    
    // Inputs
    reg clk;
    reg rst;
    reg btn;
    
    // Output
    wire led;
    
    // Instantiate the Unit Under Test (UUT) with parameters
    Top_SimpleBitPack #(
        .W_WIDTH(W_WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .btn(btn),
        .led(led)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Generate a clock with a period of 10 ns
    end
    
    // Test Cases
    initial begin
        // Initialize Inputs
        rst = 1;
        btn = 0;
    
        // Apply Reset
        #10;
        rst = 0;
    
        // Test Case 1: Button Press without Reset (Expected LED On)
        #10;
        btn = 1;  // Simulate button press
        #10;
        btn = 0;  // Release button
    
        // End of Test
        #20;
        $finish;  // Finish the simulation
    end

endmodule

