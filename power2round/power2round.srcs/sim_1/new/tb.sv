`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2024 22:02:00
// Design Name: 
// Module Name: tb
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

module tb;
    logic unsigned [22:0] t;
    logic unsigned [9:0]  t1;
    logic signed [12:0] t0;

    Power2round uut (
        .t(t),
        .t1(t1),
        .t0(t0)
    );

    initial begin
        $display("Time = %0t | t = %0d | t1 = %0d | t0 = %0d", $time, t, t1, t0);
        t = 23'd7011276;
        #10;
        
        $finish;
    end
endmodule