`timescale 1ns / 1ps

module ExpandS_tb;

    // Parameters
    localparam CLK_PERIOD = 0.2; // Clock period in ns

    // Testbench signals
    logic clk;
    logic rst;
    logic start;
    logic [511:0] rho;
    logic signed [($clog2(eta)+2):0] s1 [0:l-1][0:255];
    logic signed [($clog2(eta)+2):0] s2 [0:k-1][0:255];
//    logic done;

    // Instantiate DUT
    ExpandS dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .rho(rho),
        .s1(s1),
        .s2(s2)
//        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst = 1;
        start = 1;
        rho = 512'h903740a9bd6d69c8e640326418378f2aa9b837ccf835599197d940e64d9b1585408edc20608525229c307bcb15ce980577f34d1b309cdccd308a5cf316d24187;

        // Apply reset
        #(2 * CLK_PERIOD);
        rst = 0;

        // Provide start signal for one clock cycle
        #(CLK_PERIOD);
        start = 1;
        #(CLK_PERIOD);
        start = 1;

        // Wait for done1 signal from RejBoundedPoly



        // End simulation
        #1000;
        $finish;
    end



endmodule
