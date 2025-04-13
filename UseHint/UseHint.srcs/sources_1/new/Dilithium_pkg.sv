`timescale 1ns / 1ps

package Dilithium_pkg;

    localparam int q = 8380417;

    localparam int zeta = 1753;

    // Parameters for the ML-DSA-87 scheme
    localparam int d = 13;                        // Dropped bits from t
    localparam int tau = 60;                      // Number of ±1?s in polynomial c
    localparam int lambda = 256;                  // Collision strength of c~
    localparam int gamma1 = 524288;               // Coefficient range of y (2^19)
    localparam int gamma2 =  261888;               // Low-order rounding range (q - 1) / 32
    localparam int k = 8;                         // Number of columns in matrix A
    localparam int l = 7;                         // Number of rows in matrix A
    localparam int eta = 2;                       // Private key range
    localparam int beta = 120;                    // Degree of keyring polynomial
    localparam int omega = 75;                    // Max number of 1?s in the hint vector h

endpackage : Dilithium_pkg