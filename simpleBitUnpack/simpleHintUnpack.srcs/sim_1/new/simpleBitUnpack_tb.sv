`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2024 09:25:28
// Design Name: 
// Module Name: simpleBitUnpack_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_PolynomialConverter();
    parameter int bitlen_b = 10; // Change as needed

    logic clk;
    logic reset;
    logic [256*bitlen_b-1:0] v;
    logic [bitlen_b-1:0] w[255:0];

    // Instantiate the DUT
    PolynomialConverter #(
    .bitlen_b(bitlen_b)
    ) dut (
        .clk(clk),
        .reset(reset),
        .v(v),
        .w(w)
    );

    initial begin
        clk = 1;
        reset = 1;
        v = '0;

        #5;
        reset = 0;

        v =  2560'hc4eb23632dd35f8eb4f3dc289f4c7b503fadc4a728f9705861829c983890b0faddeea716eaa0690a212165b9614668f9af8205e74a093594fe5d4fa46dd348e1acbfaace92d0a0755e3202b254257328a795e25611c813f7ba99fd07aa1f3e5d566ae6a68d73bf65155322b6f8f15a793721cce5d2ad8fc5cf67682e14af0599ffb3a165c8fcc92b4ce68bdc1a5b47f8786ecacfd825a933d568ed3e063f2a4bb952755f560eb426cd4436e6950839c9ba80d5c09a5cfd28cb8f56b23fdea534eb2cd1c9b823352d8f74e06d1d0e8d5ed55dfcd4a65e299518bfe713a6196e0d10e32d1b3a7d8b6ffc5965c9ebe5cbde39cbc61a4c3fba0389d6bb9bdd4d940f76a9cccef952e143c44f8745734679090ca48ce552adde85c7a63b8b4c2caf5c123cb56356d945cbce07944b629be48d02ee0ed7748a1419a2977426e85e;

//        v= 256'hc4eb23632dd35f8eb4f3dc289f4c7b503fadc4a728f9705861829c983890b0faddeea716eaa0690a212165b9614668f9af8205e74a093594fe5d4fa46dd348e1;

        $display("Output z (hexadecimal): %p", w);
        #10;
        $display("Output z (hexadecimal): %p", w);
        #10;

        $finish;
    end
    
     always begin
           #2.5 clk = ~clk;
       end

        initial begin
           $dumpfile("PolynomialConverter.vcd");
           $dumpvars(0,tb_PolynomialConverter);
       end
              
   
   endmodule