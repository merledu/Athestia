`timescale 1ns / 1ps

module tb_SigDecode;

    // Parameters
    parameter int gamma1 = 524288;
    parameter int cols_l = 7;
    parameter int Lambda = 256;
    parameter int omega = 75;
    parameter int rows_k = 8;
    
    // Clock and reset
    logic clk;
    logic rst;

    // Input
    logic [37015:0] sigma;  

    // Outputs
    logic [Lambda/4 - 1:0] c_tilde;  
    logic [31:0] z [0:cols_l-1][0:255];  
    logic [255:0] h [0:rows_k-1];  
    logic valid;

    // Instantiate DUT (Device Under Test)
    SigDecode #(
        .gamma1(gamma1),
        .cols_l(cols_l),
        .Lambda(Lambda),
        .omega(omega),
        .rows_k(rows_k)
    ) dut (
        .clk(clk),
        .rst(rst),
        .sigma(sigma),
        .c_tilde(c_tilde),
        .z(z),
        .h(h),
        .valid(valid)
    );

    // Clock Generation (100 MHz)
    always #0.1 clk = ~clk;  // 10ns period (100 MHz clock)

    // Test Procedure
    initial begin
        $display("Starting Test...");

        // Initialize signals
        clk = 0;
        rst = 1;
        sigma = {640'h3210fedcbafedcba987654321fedcba987654321fedcba987654321fedcba987654321fedcba987654321fedcba987654321fedcba987654321fedcba987654321fedcba987654321fedcba987654321,36376'h0};  // Example test input (adjust as needed)

        // Apply reset
        #10;
        rst = 0;

        // Wait for unpacking process
        #500;

        // Display results
        $display("c_tilde = %h", c_tilde);
        for (int i = 0; i < cols_l; i++) begin
            for (int j = 0; j < 8; j++) begin  // Print a few z values for verification
                $display("z[%0d][%0d] = %h", i, j, z[i][j]);
            end
        end

        // Check valid flag
        if (valid) 
            $display("Decoding successful!");
        else 
            $display("Decoding not yet complete.");

        // End simulation
        #50;
        $finish;
    end

endmodule
