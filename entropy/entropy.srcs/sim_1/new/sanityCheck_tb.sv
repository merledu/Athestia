`timescale 1ns / 1ps

module SanityCheck_tb;
    parameter int N = 1000;  // Matrix size (1000x1000)
    parameter time CLK_PERIOD = 10ns;

    logic clk, rst, start;
    logic matrix [N-1:0][N-1:0];
    logic test_passed, done;

    // Instantiate the DUT (SanityCheck module)
    SanityCheck #(.N(N)) dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .matrix(matrix),
        .test_passed(test_passed),
        .done(done)
    );

    // Initialize Test
    initial begin
        int i, j;  // Declare loop variables inside the initial block

        $display("Starting Sanity Check Testbench...");
        clk = 0;
        rst = 1;
        start = 0;
        #10;
        rst = 0;
        start = 1;
        // Generate random 1000x1000 matrix
        for (i = 0; i < N; i++) begin
            for (j = 0; j < N; j++) begin
                matrix[i][j] = $urandom_range(0, 255);
            end
        end
        wait (done);
                $display("Sanity Check Completed.");
                $display("Test Result: %s", test_passed ? "PASSED" : "FAILED");
        $finish;
        end
        
       always begin
                #0.1 clk = ~clk;
            end
            
            initial begin
                $dumpfile("SanityCheck_tb.vcd");
                $dumpvars(0,SanityCheck_tb);
            end
        
      
endmodule
