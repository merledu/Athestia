`timescale 1ns / 1ps

module tb_pk_decode;
    // Parameters
    parameter int q = 12289;
    parameter int d = 2;
    parameter int k = 8;
    localparam int bitlen_q = $clog2(q);      // = 14
    localparam int bitlen_b = bitlen_q - d;   // = 12
    localparam int coeff_bits = bitlen_b;
    localparam int rho_bits = 256;
    localparam int zi_bits = 256 * coeff_bits;    // 256*12 = 3072
    localparam int total_pk_bits = rho_bits + k * zi_bits;  // 256 + 8*3072 = 24832
    
    // Testbench signals
    logic clk;
    logic rst;
    logic start;
    logic done;
    logic [total_pk_bits-1:0] pk;
    logic [255:0] rho;
    logic [k-1:0][255:0][coeff_bits-1:0] t1;
    
    // Instantiate DUT
    pk_decode #(
        .q(q),
        .d(d),
        .k(k)
    ) dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(done),
        .pk(pk),
        .rho(rho),
        .t1(t1)
    );
    
    // Clock generation (50 MHz)
    always #10 clk = ~clk;  // Slower clock for better waveform visibility
    
    // Test sequence
    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        pk = '0;
        
        // Reset phase
        #100;  // Longer reset for clear waveform observation
        rst = 0;
        
        // Create valid test vector
        pk[total_pk_bits-1 -: rho_bits] = 256'hDEADBEEF_DEADBEEF_DEADBEEF_DEADBEEF_DEADBEEF_DEADBEEF_DEADBEEF_DEADBEEF;
        
        // Fill zi sections with pattern: 0xAAA for visibility
        for(int i=0; i<k; i++) begin
            pk[total_pk_bits - rho_bits - (i+1)*zi_bits +: zi_bits] = {256{12'hAAA}};
        end
        
        // Start processing
        @(negedge clk);  // Clock synchronization
        start = 1;
        @(negedge clk);
        start = 0;
        
        // Wait for completion
        wait(done == 1);
        $display("Decoding completed at %0t ns", $time);
        
        // Verification
        if(rho === 256'hDEADBEEF_DEADBEEF_DEADBEEF_DEADBEEF_DEADBEEF_DEADBEEF_DEADBEEF_DEADBEEF)
            $display("Rho verification PASSED");
        else
            $display("Rho verification FAILED");
        
        #500;  // Additional observation time
        $finish;
    end
    
    // VCD dumping
    initial begin
        $dumpfile("tb_pk_decode.vcd");
        $dumpvars(0, tb_pk_decode);
        $display("Simulation started");
    end
endmodule