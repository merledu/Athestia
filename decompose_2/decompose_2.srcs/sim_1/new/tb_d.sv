`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2024 06:13:08 PM
// Design Name: 
// Module Name: tb_d
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2024 02:43:41 PM
// Design Name: 
// Module Name: tb_d
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


`timescale 1ns/1ps

module Decompose_tb;

    localparam int Q = 8380417;
    localparam int GAMMA = (Q - 1) / 32;

    logic [31:0] r;
    logic signed [31:0] r1;
    logic signed [31:0] r0;

    Decompose #(
        .Q(Q),
        .GAMMA(GAMMA)
    ) dut (
        .r(r),
        .r1(r1),
        .r0(r0)
    );

    initial begin
        $display("Starting Decompose Testbench");

        r = 9380417;
        #10;
        $display("Test Case 1: r = %d", r);
        $display("Result: r1 = %d, r0 = %d", r1, r0);

        r = 8380416;
        #10;
        $display("Test Case 2: r = %d", r);
        $display("Result: r1 = %d, r0 = %d", r1, r0);

        r = 522240;
        #10;
        $display("Test Case 3: r = %d", r);
        $display("Result: r1 = %d, r0 = %d", r1, r0);

        $display("Testbench completed.");
        $stop;
    end

endmodule


