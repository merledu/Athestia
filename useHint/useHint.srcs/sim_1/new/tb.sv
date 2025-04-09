`timescale 1ns/1ps

module UseHint_tb;

    // Parameters
    parameter int Q = 8380417;
    parameter int GAMMA2 = (Q-1)/32;
    parameter int WIDTH = 32;
    parameter int M = (Q-1) / (2 * GAMMA2);

    // Testbench Signals
    logic h;
    logic signed [WIDTH-1:0] r;
    logic signed [$clog2(M)-1:0] r1;

    // DUT Instance
    UseHint #(
        .Q(Q),
        .GAMMA2(GAMMA2),
        .WIDTH(WIDTH),
        .M(M)
    ) dut (
        .h(h),
        .r(r),
        .r1(r1)
    );

    // Testbench Logic
    initial begin
        $display("Starting Testbench...");
        $monitor("Time=%0t | h=%0b | r=%0d | r1=%0d", $time, h, r, r1);

        // Test Case 1: h = 0, r = 100000
        h = 0;
        r = 100000;
        #10;

        // Test Case 2: h = 1, r = 100000 (r0 > 0 expected)
        h = 1;
        r = 100000;
        #10;

        // Test Case 3: h = 1, r = -50000 (r0 <= 0 expected)
        h = 1;
        r = -50000;
        #10;

        // Test Case 4: h = 0, r = 8380416 (Edge case: r close to Q-1)
        h = 0;
        r = 8380416;
        #10;

        // Test Case 5: h = 1, r = 0 (r0 = 0)
        h = 1;
        r = 0;
        #10;

        $display("Testbench Completed.");
        $stop;
    end

endmodule
