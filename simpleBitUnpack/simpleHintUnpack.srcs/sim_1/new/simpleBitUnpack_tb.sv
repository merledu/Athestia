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


module simpleBitUnpack_tb();
    parameter int bitlen_b = 1023; // Change as needed

    logic clk;
    logic reset;
    logic [32 * $clog2(bitlen_b + 1) * 8 - 1 : 0] v;
    logic [255:0][$clog2(bitlen_b + 1)-1:0] w;

    // Instantiate the DUT
    simpleBitUnpack #(
    .b(bitlen_b)
    ) dut (
        .clk(clk),
        .reset(reset),
        .v(v),
        .w(w)
    );

    initial begin
        clk = 1;
        reset = 1;
        v = 256'h0;

        #5;
        reset = 0;

//        v =  2560'hc4eb23632dd35f8eb4f3dc289f4c7b503fadc4a728f9705861829c983890b0faddeea716eaa0690a212165b9614668f9af8205e74a093594fe5d4fa46dd348e1acbfaace92d0a0755e3202b254257328a795e25611c813f7ba99fd07aa1f3e5d566ae6a68d73bf65155322b6f8f15a793721cce5d2ad8fc5cf67682e14af0599ffb3a165c8fcc92b4ce68bdc1a5b47f8786ecacfd825a933d568ed3e063f2a4bb952755f560eb426cd4436e6950839c9ba80d5c09a5cfd28cb8f56b23fdea534eb2cd1c9b823352d8f74e06d1d0e8d5ed55dfcd4a65e299518bfe713a6196e0d10e32d1b3a7d8b6ffc5965c9ebe5cbde39cbc61a4c3fba0389d6bb9bdd4d940f76a9cccef952e143c44f8745734679090ca48ce552adde85c7a63b8b4c2caf5c123cb56356d945cbce07944b629be48d02ee0ed7748a1419a2977426e85e;
//                   c4eb23632dd35f8eb4f3dc289f4c7b503fadc4a728f9705861829c983890b0faddeea716eaa0690a212165b9614668f9af8205e74a093594fe5d4fa46dd348e1acbfaace92d0a0755e3202b254257328a795e25611c813f7ba99fd07aa1f3e5d566ae6a68d73bf65155322b6f8f15a793721cce5d2ad8fc5cf67682e14af0599...
//        v= 256'hc4eb23632dd35f8eb4f3dc289f4c7b503fadc4a728f9705861829c983890b0faddeea716eaa0690a212165b9614668f9af8205e74a093594fe5d4fa46dd348e1;
          v=2650'ha6b3a72e9acfc9a5dd0c52ab897c079da07a9daddef1ec21078b59c58398f347d4a90018cb731e4fcb022e36ff4da180a6fd222f3222cec409450a4e0dff8795f99c79da08fe6bd6f22256cfe24e913ca075684da425759e2e11c7d5bbc1c8bbe327ca57011d36d21e9d7e768c9a824b3430392d9560eb59a3c126ab17f403d396798619375ad8747949886d5d0d4d73c246a3ef736b769a3a9868adbbac355074d64a63553aef794aaae3d9504183967bcbd5826a43d232ca5413c90bf2ff8225d3991d7d696f3c91dc98cdaf31173063e58327eeb2e2d94824ee9fab022ddce392c880e522bfb6d50025199b61c2d5a2d3d2f3e8998e0a023b926691656bba13658e7711fc8445e2c4fc091f7928fe45ce13cb148ae87e6598463f4b0b3a120f48e761e30272643708c99594a5f02cb63a8aeb4ca5420c1b94e58bf7c0bee6;
          

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
           $dumpfile("simpleBitUnpack_tb.vcd");
           $dumpvars(0,simpleBitUnpack_tb);
       end
              
   
   endmodule