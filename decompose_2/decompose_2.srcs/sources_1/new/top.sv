`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2024 05:45:06 PM
// Design Name: 
// Module Name: top
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


module top_three_bytes (
    input logic btn,
    input logic clk,
    input logic rst,
    output logic led
);

    parameter int width=32;
    parameter int r1_width=32;
    parameter int r0_width=32;
    logic [width-1:0] r;  
    logic [r1_width-1:0] r1_check = 0;
    logic [r0_width-1:0] r0_check = 522240;
    logic [r1_width-1:0] r1 ;
    logic [r0_width-1:0] r0 ;

    Decompose uut (
        .r(r),
        .r1(r1),
        .r0(r0)
    );

       assign r = 9380417;


    //always_ff @(posedge clk or posedge rst) begin
        //if (~rst) begin
            //led <= 1'b0;
      always_comb begin                 
        //end else if (btn) begin
            if (r0 == 476224 && r1 == 1) begin
                led = 1'b1;
            end else begin
                led = 1'b0;
            end
        //end
    end
endmodule

