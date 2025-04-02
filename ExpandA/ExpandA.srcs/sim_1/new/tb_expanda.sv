`timescale 1ns / 1ps

module ExpandA_tb;

    // Parameters
    localparam CLK_PERIOD = 0.1; // Clock period in ns

    // Testbench signals
    logic clk;
    logic rst;
    logic start;
    logic [255:0] rho;
    logic [31:0] A [0:k-1] [0:l-1] [0:255];
//    logic done;

    // Instantiate DUT
    ExpandA dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .rho(rho),
        .A(A)
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
        rho = 256'hed059f1827b318017b44ec7436bcd5aa2362c8bc46cc6b9a549e9fa8b2151e7d;

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
