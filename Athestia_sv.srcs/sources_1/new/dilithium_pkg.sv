`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.11.2024 20:37:58
// Design Name: 
// Module Name: dilithium_pkg
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


package dilithium_pkg;
    localparam int q = 8380417;
    localparam int zeta = 1753;
    
    localparam int d = 13;                      
    localparam int hammingweight = 60;                    
    localparam int lambda = 256;                  
    localparam int gamma1 = 524288;               
    localparam int gamma2 = (q - 1) / 32;       
    localparam int k = 8;                        
    localparam int l = 7;                        
    localparam int eta = 2;                      
    localparam int beta = 120;                    
    localparam int omega = 75;                    

endpackage : dilithium_pkg