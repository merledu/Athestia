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
    logic [256*bitlen_b-1:0] v;
    logic [255:0][bitlen_b-1:0] w;
    
    logic [256*bitlen_b-1:0] compareInputBits =  2560'hc4eb23632dd35f8eb4f3dc289f4c7b503fadc4a728f9705861829c983890b0faddeea716eaa0690a212165b9614668f9af8205e74a093594fe5d4fa46dd348e1acbfaace92d0a0755e3202b254257328a795e25611c813f7ba99fd07aa1f3e5d566ae6a68d73bf65155322b6f8f15a793721cce5d2ad8fc5cf67682e14af0599ffb3a165c8fcc92b4ce68bdc1a5b47f8786ecacfd825a933d568ed3e063f2a4bb952755f560eb426cd4436e6950839c9ba80d5c09a5cfd28cb8f56b23fdea534eb2cd1c9b823352d8f74e06d1d0e8d5ed55dfcd4a65e299518bfe713a6196e0d10e32d1b3a7d8b6ffc5965c9ebe5cbde39cbc61a4c3fba0389d6bb9bdd4d940f76a9cccef952e143c44f8745734679090ca48ce552adde85c7a63b8b4c2caf5c123cb56356d945cbce07944b629be48d02ee0ed7748a1419a2977426e85e;

    
    
  
    logic [255:0][82:0] CheckOutput = '{8'h4b,8'h2b,8'h0b,8'h0,8'h0,8'h0,8'h0,8'h0,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'h0a,8'h02,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'ha,8'h2,8'ha,8'h9,8'h8,8'h7,8'h1,8'h0,8'h2,8'h2,8'h2,8'h2,8'h5} ;
   //   logic start;
   parameter int bitlen_b = 10;
    PolynomialConverter #(
   .bitlen_b(bitlen_b)
   ) dut (
       .clk(clk),
       .reset(reset),
       .v(v),
       .w(w)
   );
   // localparam start =1'b1 ;
   always @(*) begin
        // Default values to avoid latches
     
        led = 1'b0;
    
        if (rst) begin
         
            led = 1'b0;
        end else begin
            // Handle cases
           // case (btn)
             if(btn) begin
              //  start: begin`
                    v = compareInputBits;
                   
    
                    if (w== CheckOutput) begin
                        led = 1'b1;
                    end else begin
                        led = 1'b0;
                        
                    end
            //        h = {256'h0,256'h0,256'h0,256'h0,256'h0,256'h0,256'h0,256'h0};
                end
            
              else begin      // Default state for other cases
                  
                    led = 1'b0;
                    
                end
           // endcase
        end
    end


  endmodule