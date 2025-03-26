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


module verifyInternalModule #(
    parameter int PK_SIZE = 20736,  //  2592  bytes
    parameter int MSG_MAX_SIZE = 1024,    // Maximum message size (adjustable)
    parameter int SIG_SIZE = 37016      // 4627 bytes
)(
    input logic clk,
    input logic [PK_SIZE-1:0] pk,     // Public key input
    input logic [MSG_MAX_SIZE-1:0] M, // Message input
    input logic [SIG_SIZE-1:0] sigma, // Signature input
    output logic valid                // Output Boolean result
);
logic [255:0] t1_data;
always_ff @(posedge clk) begin
t1_data <= pk[255:0];
end
pkDecode  u_pkDecode (
        .clk(clk),
        .pk(pk),
        .rho(rho),
        .t1(t1)
    );

endmodule