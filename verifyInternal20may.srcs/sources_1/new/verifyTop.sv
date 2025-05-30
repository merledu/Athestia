`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2025 03:00:12 PM
// Design Name: 
// Module Name: verifyTop
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


module VerifyTop #(
    parameter int PK_SIZE = 20736,  // 2592 bytes
    parameter int MSG_MAX_SIZE = 27672, // Maximum message size
    parameter int SIG_SIZE = 37016,  // 4627 bytes
    parameter MAX_CTX_LEN  = 2032
)(
    input logic clk,
    input logic rst,
    input  logic [PK_SIZE-1:0] pk,
    input  logic [MSG_MAX_SIZE-1:0] M ,
//    input  int               M_len,
    input  logic [SIG_SIZE-1:0] sigma,
    input  logic [MAX_CTX_LEN-1:0] ctx  ,
    input logic  start, 
    input  int               ctx_len,

    output logic         valid,
    
    output logic done
);

    localparam MAX_MPRIME_LEN = 8 + 8 + MAX_CTX_LEN + MSG_MAX_SIZE;//8+8+MAX_CTX_LEN + MSG_MAX_SIZE

    logic [MAX_MPRIME_LEN-1:0] M_prime ;
    int M_prime_len;
    

    // Temporary variables
    logic internal_done; 
    logic ctx_len = ($bits(ctx) / 8);
    

    // Instantiate Verify_internal
    logic internal_verified;
    
    verifyInternalModule #(
            .PK_SIZE(PK_SIZE),  //  2592  bytes
            .MSG_MAX_SIZE(MSG_MAX_SIZE),    // Maximum message size (adjustable)
            .SIG_SIZE(SIG_SIZE)  
        ) dut (
            .clk(clk),
            .rst(rst),
            .pk(pk),
            .M(M_prime),
            .sigma(sigma),
            .valid(internal_verify_valid),
            .initial_start(start),
             .done(internal_done)
        );
    

    // Assign output
    always_comb begin
    M_prime = {M,ctx,($bits(ctx) / 8),8'd0};//{8'd0,($bits(ctx) / 8),ctx,M};//  // {0 , ($bits(ctx) / 8), ctx , M};
      $display("Hex value M_prime = %h", M_prime);
        if (ctx_len > 255) begin
            valid = 0;
                    done = 1;
        end else begin
            valid = internal_verify_valid;
            done = internal_done;
        end
    end

endmodule
