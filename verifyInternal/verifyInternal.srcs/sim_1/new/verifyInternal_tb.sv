module verifyInternal_tb;
    // Define parameters inside the testbench
    parameter int PK_SIZE = 20736;  // 2592 bytes
    parameter int MSG_MAX_SIZE = 1024; // Maximum message size
    parameter int SIG_SIZE = 37016;  // 4627 bytes

    // Declare signals
    reg clk;  // Must be 'reg' for procedural assignment
    reg [PK_SIZE-1:0] pk;  
    reg [MSG_MAX_SIZE-1:0] M;  
    reg [SIG_SIZE-1:0] sigma;  
    wire valid;  // Assume 'valid' is an output from the DUT

    // Instantiate the Device Under Test (DUT)
    verifyInternalModule dut (
        .clk(clk),
        .pk(pk),
        .M(M),
        .sigma(sigma),
        .valid(valid)
    );

    // Clock generation (Toggle every 0.5 time units)
    always #0.5 clk = ~clk;

    // Testbench sequence
    initial begin
        clk = 1'b0; // Initialize clock
        pk = 0;
        M = 0;
        sigma = 0;

        #50;  // Wait for some time before finishing the simulation

        $finish;
    end

    // Dump waveforms for debugging
    initial begin
        $dumpfile("verifyInternal_tb.vcd");
        $dumpvars(0, verifyInternal_tb);
    end
endmodule
