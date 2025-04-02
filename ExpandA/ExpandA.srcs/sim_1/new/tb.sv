`timescale 1ns / 1ps
import Dilithium_pkg::*;

module tb_RejNttPoly;

    // Parameters

    // Testbench signals
    logic clk;
    logic rst;
    logic start;
    logic [271:0] rho;
    logic signed [31:0] A [0:255];
    logic done;

    // DUT instantiation
    RejNttPoly uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .rho(rho),
        //.shakeOut(shakeOut),
        .A(A),
        .done(done)
    );

    // Clock generation
    always #1 clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        start = 0;
        rho = 0;
//        shakeOut = 0;

        // Reset pulse
        rst = 1;
        #2;
        rst = 0;

        // Apply test stimulus
        @(negedge clk);
        start = 1;
        rho = 272'h0202a5a01f366a002b52ff3e47fc58200276a208452add8e6adfff29bdbf9f18824e;
        //shakeOut = 4096'hdff22f65691f44b4b6b96bd526a23dead4b472e44f5d2b6d63f61da76d4b605663f25dd27c50af33c149936e7502229fd8f0f2336e2cc881151c9ee1af5e1a89c2afdd80983277fa205ebbe2cdf190e5326a6b857235aba7e31156fb207560b3c958e7f7250993396d7466c5f12f5a36b8f0b9aa5629ce1059cbf5ea9cbe245352d3af1e9e6cd5ec0cea9036d0b37aee46624815532e9df9ae2583d5554586c70d40f4c2550448b6d3c44acde42de4b841b5ba5df14ae04a4bedff8342f1273bbf491e0b67b7834315b129a27a0ff93d42ab6cdf4f857fdf3b86bd04832b30985e9fe48e91ff0a3c564ec71f7c9bc71be4252d4c209cd1ada705ec1ac09d6f6306f57024e4cd3c66048df55ca8a8396e0559237a8e84775f18dbe6e7da8718bce50efdfb9ee638c2efc4ead5fe371f99bf4fe3fa6bb30b8d44b51d7e090dd884b776fb743bdea2976157cc0540d73b523f0e629d179c8bc08c009f599e0143a4e2ac4f9d7f7299537672b6a7ae5bf9a52e83f906184ce50d7821a4713cfa94bc87c263d47100ca2227ba4bd9c4d0f5a55c70e67836a04f41ffc36b35aa932675057911fed907eacf851541c07663ff3728b447082d59477704422398531c346bb886b50a7600ddf1a68b5cf14d43dadc17bd1d3a422a96b95e11cdd4bef6bdd82dc4e956d3c76bc1e524fcd52e6abbbbef20ef7f00876c8434178b00477b7544; // Example value

        @(negedge clk);
        start = 1;

        repeat (1000) @(posedge clk);

        $stop;
    end

endmodule
