`timescale 1ns / 1ps

module tb_skEncode;

    // Parameters
    parameter int cols_l = 7;
    parameter int rows_k = 8;
    parameter int n = 2;
    parameter int d = 13;

    // Inputs
     logic clk;
      logic  rst;
    logic done;
    logic [255:0] rho;
    logic [255:0] K;
    logic [511:0] tr;
    logic signed  [$clog2(n + n):0]  s1[6:0][255:0];
    logic  signed [$clog2(n + n):0]  s2[7:0][255:0];
    logic  signed   [$clog2(( (1 << d-1) - 1) +(1 << d-1))-1:0] t0[7:0][255:0];

    // Output
    logic [39167:0] sk;

    // Instantiate the DUT
    skEncode #(
         
        .cols_l(cols_l),
        .rows_k(rows_k),
        .n(n),
        .d(d)
    ) dut (
    .clk(clk),
    .rst(rst),
        .rho(rho),
        .K(K),
        .tr(tr),
        .s1(s1),
        .s2(s2),
        .t0(t0),
        .sk(sk),
        .done(done)
    );
    always #5 clk = ~clk;
    initial begin
         clk=1;
         rst=0;
             
        // Static initialization of inputs
        rho = 256'hDEADBEEFCAFEBABE1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF;
        K = 256'h0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF;
        tr = 512'hAABBCCDDEEFF00112233445566778899AABBCCDDEEFF00112233445566778899AABBCCDDEEFF00112233445566778899AABBCCDDEEFF00112233445566778899;

        // Static initialization of s1
      for (int i = 0; i < cols_l; i++) begin
             for (int j = 0; j <256; j++) begin
               s1[i][j] = i + j;  // Example initialization
             end
           end
       
           // Initialize s2
           for (int i = 0; i < rows_k; i++) begin
             for (int j = 0; j <256; j++) begin
               s2[i][j] = i * j;  // Example initialization
             end
           end
       
           // Initialize t0
           for (int i = 0; i < rows_k; i++) begin
             for (int j = 0; j < 256; j++) begin
               t0[i][j] = (i + j) % (1 << d);  // Example initialization
             end
           end
        // Wait for some time to observe output
        #1000;

        // Display t0he results
        $display("Output sk: %h", sk);

        // End simulation
        $finish;
    end

endmodule
