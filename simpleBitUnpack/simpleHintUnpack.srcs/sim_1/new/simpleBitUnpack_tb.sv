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
    logic [(32 * $clog2(bitlen_b + 1) * 8) - 1 : 0] v;
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
//      
//  v= 256'hc4eb23632dd35f8eb4f3dc289f4c7b503fadc4a728f9705861829c983890b0faddeea716eaa0690a212165b9614668f9af8205e74a093594fe5d4fa46dd348e1;
   //pqc code
//        v=2650'ha6b3a72e9acfc9a5dd0c52ab897c079da07a9daddef1ec21078b59c58398f347d4a90018cb731e4fcb022e36ff4da180a6fd222f3222cec409450a4e0dff8795f99c79da08fe6bd6f22256cfe24e913ca075684da425759e2e11c7d5bbc1c8bbe327ca57011d36d21e9d7e768c9a824b3430392d9560eb59a3c126ab17f403d396798619375ad8747949886d5d0d4d73c246a3ef736b769a3a9868adbbac355074d64a63553aef794aaae3d9504183967bcbd5826a43d232ca5413c90bf2ff8225d3991d7d696f3c91dc98cdaf31173063e58327eeb2e2d94824ee9fab022ddce392c880e522bfb6d50025199b61c2d5a2d3d2f3e8998e0a023b926691656bba13658e7711fc8445e2c4fc091f7928fe45ce13cb148ae87e6598463f4b0b3a120f48e761e30272643708c99594a5f02cb63a8aeb4ca5420c1b94e58bf7c0bee6;
        //hex wise reverse
//        v=2560'he6bec0f78be5941b0c42a54ceb8a3ab62cf0a59495c90837647202e361e7480f123a0b4b3f4698657ee88a14cb13ce45fe28791f09fcc4e24584fc11778e6513ba6b659166923b020a8e99e8f3d2d3a2d5c2619b192500d5b6bf22e580c892e3dc2d02ab9fee2448d9e2b2ee2783e563301731afcd98dc913c6f697d1d99d32582fff20bc91354ca32d2436a82d5cb7b96834150d9e3aa4a79ef3a55634ad6745035acbbad68983a9a766b73efa346c2734d0d5d6d88497974d85a3719867996d303f417ab26c1a359eb60952d3930344b829a8c767e9d1ed2361d0157ca27e3bbc8c1bbd5c7112e9e7525a44d6875a03c914ee2cf5622f2d66bfe08da799cf99587ff0d4e0a4509c4ce22322f22fda680a14dff362e02cb4f1e73cb1800a9d447f39883c5598b0721ecf1dead9d7aa09d077c89ab520cdda5c9cf9a2ea7b3a6;
         //atestia code v0 b=1023
//            v=2650'h485cd0d2fc6219a67e175128d3c873a27f149ef8903f2347a2213f88ee71a6c85dd6a6896649dc4050719917cf4bcb45ab4386d998a400ab6dfd44a7011349c73bb440d5f97724129b474d77e4c1a7c60ce88cf5b3193b893cf696beb899cba441ff4fd093c82a534c4bc25641abd3de69c1820a9bc755529ef75caac6526b2e0aac35ddb516195c596ed6cef7c56243ceb2b0bab611929e2e1b5aec98619e69cbc02fe8d56483c59ad706a9b49c0c2cd24159316e7eb9784b6cb880ea53e4c7dd1383ddabe3887479aea425b216ae053c897247f36a444f6bd67f105b9e399fa9e1ffb07250a2902373444cf444bf650185b2ff6c7440d3f278ced31800952be2cf19c1a39ad1e084378f7bb5b95e05b9e03e91d54a30bba593f35974e5cd65d1cfacfa2d0e7955caeccec3ca3dbae0d572581704e9f6b459f93321b30e4c8a;
            //atestia reverse string in binary. convert into hex
            v=2650'h513270cd84cc9f9a2d6f9720e81a4eab075dbc53c3733753aa9e70b45f35f38ba6b3a72e9acfc9a5dd0c52ab897c079da07a9daddef1ec21078b59c58398f347d4a90018cb731e4fcb022e36ff4da180a6fd222f3222cec409450a4e0dff8795f99c79da08fe6bd6f22256cfe24e913ca075684da425759e2e11c7d5bbc1c8bbe327ca57011d36d21e9d7e768c9a824b3430392d9560eb59a3c126ab17f403d396798619375ad8747949886d5d0d4d73c246a3ef736b769a3a9868adbbac355074d64a63553aef794aaae3d9504183967bcbd5826a43d232ca5413c90bf2ff8225d3991d7d696f3c91dc98cdaf31173063e58327eeb2e2d94824ee9fab022ddce392c880e522bfb6d50025199b61c2d5a2d3d2f3e8998e0a023b926691656bba13658e7711fc8445e2c4fc091f7928fe45ce13cb148ae87e6598463f4b0b3a12;

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