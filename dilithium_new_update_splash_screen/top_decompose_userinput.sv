`timescale 1ns / 1ps

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
    logic [r0_width-1:0] r0_check = 1234;
    logic [r1_width-1:0] r1 ;
    logic [r0_width-1:0] r0 ;

    Decompose uut (
        .r(r),
        .r1(r1),
        .r0(r0)
    );

    assign r = 1234;

    always_comb begin                 
        if (r0 == r0_check && r1 == r1_check) begin
            led = 1'b1;
        end else begin
            led = 1'b0;
        end
    end
endmodule
