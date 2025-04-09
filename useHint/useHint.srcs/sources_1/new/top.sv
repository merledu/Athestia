`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2024 07:59:18 PM
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


module top (
    input logic btn,
    input logic clk,
    input logic rst,
    output logic led
);


    parameter int Q = 8380417;
    parameter int GAMMA2 = (Q-1)/32;
    parameter int WIDTH = 32;
    parameter int M = (Q-1) / (2 * GAMMA2);

    // Testbench Signals
    logic h;
    logic signed [WIDTH-1:0] r;
    logic signed [$clog2(M)-1:0] r1;
    logic signed [$clog2(M)-1:0] r1_check;
    
    initial begin
    r = 4294917296;
    h = 1;
    r1_check = 8;
    end

    // DUT Instance
    UseHint #(
        .Q(Q),
        .GAMMA2(GAMMA2),
        .WIDTH(WIDTH),
        .M(M)
    ) dut (
        .h(h),
        .r(r),
        .r1(r1)
    );



//       assign w1 = 


    //always_ff @(posedge clk or posedge rst) begin
        //if (~rst) begin
            //led <= 1'b0;
      always_comb begin                 
        //end else if (btn) begin
            if (r1_check == r1) begin
                led = 1'b1;
            end else begin
                led = 1'b0;
            end
        //end
    end
endmodule
