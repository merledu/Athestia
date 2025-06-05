`timescale 1ns / 1ps

module KeyGen_tb;

    // Clock and reset
    logic clk;
    logic rst;

    // Outputs
    logic final_done;
    logic [39167:0] sk;
    logic [20735:0] pk;

    // Instantiate the DUT (Device Under Test)
    KeyGen uut (
        .clk(clk),
        .rst(rst),
        .final_done(final_done),
        .sk(sk),
        .pk(pk)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #0.005 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize
        rst = 1;
        #10;
        rst = 0;

        // Wait for final_done signal
        wait(final_done == 1);


        #10;
        $finish;
    end

endmodule
