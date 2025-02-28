`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2024 12:52:44
// Design Name: 
// Module Name: Power2round
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

module Power2round #(
    parameter int T_WIDTH = 23,  
    parameter int T1_WIDTH = 10, 
    parameter int T0_WIDTH = 13 
)(

    input  logic unsigned [T_WIDTH-1:0] t,        
    output logic unsigned [T1_WIDTH-1:0] t1,      
    output logic signed [T0_WIDTH-1:0] t0         
);

    logic signed [T_WIDTH-1:0] t_shifted;

    always_comb begin
        t_shifted = t + (1 << (d - 1)) - 1;
        t1 = t_shifted >>> d;
        t0 = t - (t1 <<< d);  
    end

endmodule















//module Power2round (
//    input  logic unsigned [22:0] t,        // 23-bit input t
//    output logic unsigned [9:0]   t1,      // 10-bit output t1
//    output logic signed [12:0]  t0       // 13-bit output t0
//);

//    logic signed [22:0] t_shifted;

//    always_comb begin
//        t_shifted = t + (1 << (d - 1)) - 1;
//        t1 = t_shifted >>> d;

//        t0 = t - (t1 <<< d);  
//    end

//endmodule