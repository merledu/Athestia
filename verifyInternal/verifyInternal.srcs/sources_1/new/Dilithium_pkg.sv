`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2024 12:58:48
// Design Name: 
// Module Name: Dilithium_pkg
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

package Dilithium_pkg;

    localparam int q = 8380417;

    localparam int zeta = 1753;

    // Parameters for the ML-DSA-87 scheme
    localparam int d = 13;                        // Dropped bits from t
    localparam int tau = 60;                      // Number of ?1?s in polynomial c
    localparam int lambda = 256;                  // Collision strength of c~
    localparam int gamma1 = 524288;               // Coefficient range of y (2^19)
    localparam int gamma2 = (q - 1) / 32;         // Low-order rounding range
    localparam int k = 8;                         // Number of columns in matrix A
    localparam int l = 7;                         // Number of rows in matrix A
    localparam int eta = 2;                       // Private key range
    localparam int beta = 120;                    // Degree of keyring polynomial
    localparam int omega = 75;                    // Max number of 1?s in the hint vector h
    localparam int bLog2  = 9;                       //log2(1024) -1

endpackage : Dilithium_pkg
