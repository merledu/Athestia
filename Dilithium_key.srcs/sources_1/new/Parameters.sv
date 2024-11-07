`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2024 01:07:26 PM
// Design Name: 
// Module Name: Parameters
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

//module Parameters;
//    // ML-DSA-87 Parameter Set
//    localparam int q = 8380417;                  
//    localparam int zeta = 1753;                  
//    localparam int d = 13;                       
//    localparam int tau = 60;
//    localparam int lambda = 256;
//    localparam int gamma1 = 524288;            // Coefficient range of y (2^19)
//    localparam int gamma2 = (q - 1) / 32;
//    localparam int k = 8;
//    localparam int l = 7;
//    localparam int eta = 2;
//    localparam int beta = 120;
//    localparam int omega = 75;

//endmodule






// Parameters.sv
`ifndef PARAMETERS_SV
`define PARAMETERS_SV

// Global constants defined as macros
`define Q 8380417
`define ZETA 1753
`define D 13
`define TAU 60
`define LAMBDA 256
`define GAMMA1 524288
`define GAMMA2 ((`Q - 1) / 32)
`define K 8
`define L 7
`define ETA 2
`define BETA 120
`define OMEGA 75

`endif

