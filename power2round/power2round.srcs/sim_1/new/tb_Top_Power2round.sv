`timescale 1ns / 1ps

module tb_Top_Power2round;
    parameter int T_WIDTH = 23;
    parameter int T1_WIDTH = 10;
    parameter int T0_WIDTH = 13;

    // Inputs
    reg clk;
    reg rst;
    reg btn;

    // Output
    wire led;

    // Instantiate the Unit Under Test (UUT) with parameters
    Top_Power2round #(
        .T_WIDTH(T_WIDTH),
        .T1_WIDTH(T1_WIDTH),
        .T0_WIDTH(T0_WIDTH)
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










//module tb_Top_Power2round;

//    // Inputs
//    reg clk;
//    reg rst;
//    reg btn;

//    // Output
//    wire led;

//    // Instantiate the Unit Under Test (UUT)
//    Top_Power2round uut (
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
//        #10;
//        btn = 1;  // Simulate button press
//        #10;
//        btn = 0;  // Release button

//        // End of Test
//        #20;
//        $finish;  // Finish the simulation
//    end

//endmodule
