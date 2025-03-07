`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2024 11:56:58
// Design Name: 
// Module Name: SimpleBitUnpack_top
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


module top (
    input logic clk,
    input logic rst,
   
    input logic btn,
    output logic led  
      
);
    parameter int bitlen_b = 10;

    logic [32 * bitlen_b * 8 - 1 : 0] v;
    logic [255:0][bitlen_b-1:0] w;
    
    logic [32 * bitlen_b * 8 - 1 : 0] compareInputBits =  2560'ha6b3a72e9acfc9a5dd0c52ab897c079da07a9daddef1ec21078b59c58398f347d4a90018cb731e4fcb022e36ff4da180a6fd222f3222cec409450a4e0dff8795f99c79da08fe6bd6f22256cfe24e913ca075684da425759e2e11c7d5bbc1c8bbe327ca57011d36d21e9d7e768c9a824b3430392d9560eb59a3c126ab17f403d396798619375ad8747949886d5d0d4d73c246a3ef736b769a3a9868adbbac355074d64a63553aef794aaae3d9504183967bcbd5826a43d232ca5413c90bf2ff8225d3991d7d696f3c91dc98cdaf31173063e58327eeb2e2d94824ee9fab022ddce392c880e522bfb6d50025199b61c2d5a2d3d2f3e8998e0a023b926691656bba13658e7711fc8445e2c4fc091f7928fe45ce13cb148ae87e6598463f4b0b3a120f48e761e30272643708c99594a5f02cb63a8aeb4ca5420c1b94e58bf7c0bee6;

    

  
    logic [255:0][bitlen_b-1:0] CheckOutput = '{10'h3A6, 10'h1EC, 10'h2EA, 10'h268, 10'h1CF, 10'h172, 10'h1DA, 10'h033, 10'h352, 10'h26A, 10'h3C8, 10'h01D, 10'h09D, 10'h2A8, 10'h1D7, 10'h2B6, 10'h1DE, 10'h33C, 10'h21E, 10'h01C, 10'h18B, 10'h156, 10'h03C, 10'h262, 10'h3F3, 10'h111, 10'h29D, 10'h002, 10'h318, 10'h0F2, 10'h1E7, 10'h13C, 10'h2CB, 10'h380, 10'h362, 10'h3FC, 10'h14D, 10'h028, 10'h268, 10'h3F6, 10'h322, 10'h08B, 10'h223, 10'h338, 10'h1C4, 10'h142, 10'h0A4, 10'h138, 10'h30D, 10'h1FF, 10'h158, 10'h3E6, 10'h19C, 10'h29E, 10'h08D, 10'h3F8, 10'h26B, 10'h0B5, 10'h22F, 10'h158, 10'h2CF, 10'h3B8, 10'h114, 10'h0F2, 10'h1A0, 10'h21D, 10'h0D6, 10'h291, 10'h125, 10'h39D, 10'h2E9, 10'h044, 10'h1C7, 10'h2F5, 10'h01B, 10'h323, 10'h3BB, 10'h1F8, 10'h0A2, 10'h15F, 10'h101, 10'h187, 10'h123, 10'h07B, 10'h29D, 10'h19F, 10'h0C7, 10'h26A, 10'h382, 10'h112, 10'h303, 10'h0E4, 10'h12D, 10'h025, 10'h2B6, 10'h167, 10'h1A3, 10'h1B0, 10'h2B2, 10'h05E, 10'h3F4, 10'h0C0, 10'h16D, 10'h1E6, 10'h186, 10'h1C6, 10'h1A3, 10'h361, 10'h174, 10'h25E, 10'h084, 10'h1B6, 10'h15D, 10'h343, 10'h334, 10'h309, 10'h346, 10'h3E8, 10'h33E, 10'h1AD, 10'h276, 10'h2A6, 10'h183, 10'h1A2, 10'h3AD, 10'h32E, 10'h35A, 10'h140, 10'h274, 10'h2B5, 10'h234, 10'h155, 10'h33A, 10'h27B, 10'h0A7, 10'h2A9, 10'h1E3, 10'h036, 10'h015, 10'h20D, 10'h396, 10'h2DE, 10'h15C, 10'h20B, 10'h36A, 10'h090, 10'h32D, 10'h328, 10'h354, 10'h244, 10'h0BC, 10'h3C8, 10'h2FF, 10'h160, 10'h132, 10'h267, 10'h11D, 10'h25F, 10'h2F6, 10'h0F1, 10'h091, 10'h237, 10'h0D9, 10'h2BF, 10'h331, 10'h005, 10'h233, 10'h395, 10'h383, 10'h389, 10'h32E, 10'h38A, 10'h0D9, 10'h112, 10'h2E2, 10'h27F, 10'h2AB, 10'h340, 10'h1C2, 10'h38F, 10'h092, 10'h032, 10'h258, 10'h08B, 10'h2BF, 10'h16D, 10'h00D, 10'h094, 10'h319, 10'h066, 10'h026, 10'h357, 10'h3A2, 10'h0B4, 10'h33D, 10'h3A3, 10'h299, 10'h2A3, 10'h020, 10'h0EC, 10'h292, 10'h059, 10'h259, 10'h1AD, 10'h3BA, 10'h144, 10'h0E6, 10'h1DE, 10'h011, 10'h13F, 10'h058, 10'h389, 10'h0C4, 10'h27F, 10'h1F0, 10'h1E4, 10'h228, 10'h17F, 10'h0E4, 10'h04F, 10'h0CB, 10'h285, 10'h288, 10'h1FB, 10'h065, 10'h1A6, 10'h3F4, 10'h12C, 10'h20B, 10'h08E, 10'h0F1, 10'h120, 10'h1E7, 10'h0D8, 10'h02E, 10'h1C8, 10'h364, 10'h20D, 10'h090, 10'h257, 10'h194, 10'h029, 10'h2CF, 10'h2D8, 10'h23A, 10'h2E2, 10'h0CE, 10'h295, 10'h042, 10'h2C3, 10'h141, 10'h396, 10'h38B, 10'h03D, 10'h3EC, 10'h39A};
   //   logic start;
   simpleBitUnpack #(
    .b(bitlen_b)
    ) dut (
        .clk(clk),
        .reset(rst),
        .v(v),
        .w(w)
    );
   // localparam start =1'b1 ;
   always @(posedge clk) begin
        // Default values to avoid latches
     
        led <= 1'b0;
    
        if (rst) begin
         
            led <= 1'b0;
        end else begin
            // Handle cases
           // case (btn)
             if(btn) begin
              //  start: begin`
                    v <= compareInputBits;
                   
    
                    if (w== CheckOutput) begin
                        led <= 1'b1;
                    end else begin
                        led <= 1'b0;
                        
                    end
            //        h = {256'h0,256'h0,256'h0,256'h0,256'h0,256'h0,256'h0,256'h0};
                end
            
              else begin      // Default state for other cases
                  
                    led <= 1'b0;
                    v <= compareInputBits;
                    
                end
           // endcase
        end
    end


  endmodule