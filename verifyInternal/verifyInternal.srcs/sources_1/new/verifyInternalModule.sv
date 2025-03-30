`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2025 19:08:03
// Design Name: 
// Module Name: verifyInternalModule
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
import Dilithium_pkg::*;


module verifyInternalModule #(
    parameter int PK_SIZE = 20736,  //  2592  bytes
    parameter int MSG_MAX_SIZE = 1024,    // Maximum message size (adjustable)
    parameter int SIG_SIZE = 37016,      // 4627 bytes
//  for shake parameter  
    parameter d_len = 7000
)(
    input logic clk,rst,
    input logic [PK_SIZE-1:0] pk,     // Public key input
    input logic [MSG_MAX_SIZE-1:0] M, // Message input
    input logic [SIG_SIZE-1:0] sigma, // Signature input
    output logic valid                // Output Boolean result
);

logic start=1'b1;

// define output for pk deccode module
logic [255:0] rho;
logic [k-1:0][255:0][bLog2:0] t1;

//define output for expand A module
logic [31:0] A [0:k-1] [0:l-1] [0:255];
logic expandADone;

//define output for shake with pk input
logic [d_len - 1: 0] tr;
logic shakeDonePK;

//define output for shake with tr and M
logic [d_len - 1: 0] shakeZ;
logic shakeDoneMTr;

always_ff @(posedge clk) begin
end

//call pkdeocode module
pkDecode  u_pkDecode (
        .clk(clk),
        .pk(pk),
        .rho(p), //output
        .t1(t1)
    );
    
 //callsigdeocode module
 
 //call expand a module
 
 ExpandA  ExpandAModule (
         .clk(clk),
         .rst(rst),
         .rho(p), //from pkdecode rh0
         .start(start),
         .A(A),
         .done(expandADone)
     );
     
  //call module shake with pk
  sponge shakePK(
  .clk(clk),
  .reset(rst),
  .message(pk),
  .start(start),
  .z(tr),
  .done(shakeDonePK)
  );
  
  //call module shake with tr and m
    sponge shakeMTr(
    .clk(clk),
    .reset(rst),
    .message({shakeZ ,M} ),
    .start(start),
    .z(mu),
    .done(shakeDoneMTr)
    );



endmodule