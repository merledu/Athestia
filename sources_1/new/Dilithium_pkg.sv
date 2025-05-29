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
    localparam int tau = 60;                      // Number of �1?s in polynomial c
    localparam int lambda = 256;                  // Collision strength of c~
    localparam int gamma1 = 524288;               // Coefficient range of y (2^19)
    localparam int gamma2 = (q - 1) / 32;         // Low-order rounding range
    localparam int k = 8;                         // Number of columns in matrix A
    localparam int l = 7;                         // Number of rows in matrix A
    localparam int eta = 2;                       // Private key range
    localparam int beta = 120;                    // Degree of keyring polynomial
    localparam int omega = 75;                    // Max number of 1?s in the hint vector h
    
//    category 5 paramters
    localparam int extract_bit_rho = 255;           //8*32-1
        localparam int y_bits = 663;
        localparam int sigmabits_sig_decode= 37016;
        localparam int c_tilde_bits = 511;//(cl*8)-1;
        localparam int v_bits = 5119;//((flog2((gamma1-1) + gamma1 + 1)) * 256) - 1;
        localparam int bl_sigdecode = 32*(1+$clog2(gamma1-1)); 
        
    // define parameters for verify module line no 9
        localparam int d_power2 = 8192; // d**2
endpackage : Dilithium_pkg