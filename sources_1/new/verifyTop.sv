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

    output logic         valid,
    
    output logic done
);

    localparam MAX_MPRIME_LEN = 8 + 8 + MAX_CTX_LEN + MSG_MAX_SIZE;//8+8+MAX_CTX_LEN + MSG_MAX_SIZE

    logic [7:0] M_prime [MAX_MPRIME_LEN];
    int M_prime_len;

    // Temporary variables
    logic internal_done; 
//    int i;
//    logic [7:0] zero_byte = 8'h00;

//    always_comb begin
//        if (($bits(hex_val) / 8) > 255) begin
//            valid = 0;
//            done = 1;
//        end else begin
//            // Build M_prime = 0x00 || len(ctx) || ctx || M
//            M_prime[0] = zero_byte;
//            M_prime[1] = ctx_len[7:0]; // IntegerToBytes(len(ctx), 1)
//            M_prime_len = 2;

//            // Append ctx
//            for (i = 0; i < ctx_len; i++) begin
//                M_prime[M_prime_len] = ctx[i];
//                M_prime_len++;
//            end

//            // Append M
//            for (i = 0; i < M_len; i++) begin
//                M_prime[M_prime_len] = M[i];
//                M_prime_len++;
//            end
//        end
//    end

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
            .M(M),
            .sigma(sigma),
            .valid(internal_verify_valid),
            .initial_start(start),
             .done(internal_done)
        );
    
//    verifyInternalModule #(
//        .MAX_PK_LEN(MAX_PK_LEN),
//        .MAX_M_LEN(MAX_MPRIME_LEN),
//        .MAX_SIGN_LEN(MAX_SIGN_LEN)
//    ) internal (
//        .clk(clk),
//        .rst(rst),
//        .initial_start(start),
//        .pk(pk),
//        .M(M_prime),
//        .sigma(sign),
//        .valid(sign_len),
//        .done(internal_verified)
//    );

    // Assign output
    always_comb begin
        if (($bits(ctx) / 8) > 255) begin
            valid = 0;
                    done = 1;
        end else begin
            valid = internal_verify_valid;
            done = internal_done;
        end
    end

endmodule
