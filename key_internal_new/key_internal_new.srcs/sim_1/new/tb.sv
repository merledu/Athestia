`timescale 1ns/1ps

module KeyInternal_tb;
    // Parameter for clock period
    parameter clock_period = 0.1;
    
    // DUT Signals
    logic clk;
    logic rst;
    logic [255:0] zeta;
    
    // Instantiate the DUT (Device Under Test)
    key_internal uut (
        .clk(clk),
        .rst(rst),
        .zeta(zeta)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #(clock_period) clk = ~clk;
    end

    // Testbench Stimulus
    initial begin
        // Initialize inputs
        rst = 1;
        zeta = 256'h0;
        
        // Reset sequence
        #clock_period;
        rst = 0;
        
        // Test with different zeta values
        zeta = 256'h24caa1b44d22446b945452a70af1d8b83f6adbd0030f12d11c684681596d4ca5;

        
        // Finish Simulation
        #1000;
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time = %0t | clk = %b | rst = %b | zeta = %h", $time, clk, rst, zeta);
    end

endmodule
