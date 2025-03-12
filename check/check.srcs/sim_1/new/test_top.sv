//`timescale 1ns / 1ps

//module test_top;

//    // Inputs
//    reg clk;
//    reg rst;
//    reg btn;

//    // Output
//    wire led;

//    // Instantiate the Unit Under Test (UUT)
//    top_bitpack uut (
//        .clk(clk),
//        .rst(rst),
//        .btn(btn),
//        .led(led)
//    );

//    // Clock generation
//    initial begin
//        clk = 0;
//        forever #5 clk = ~clk; // Generate a clock with a period of 10 ns
//    end

//    // Test Cases
//    initial begin
//        // Initialize Inputs
//        rst = 1;
//        btn = 0;

//        // Apply Reset
//        #10;
//        rst = 0;

//        // Test Case 1: Button Press without Reset (Expected LED On)
//        #20;
//        btn = 1;  // Simulate button press
//        #20;
//        btn = 0;  // Release button

//        // End of Test
//        #20;
//        $finish;  // Finish the simulation
//    end
//    endmodule