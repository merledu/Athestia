`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2024 08:28:55 PM
// Design Name: 
// Module Name: useHint
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


module UseHint #(
    parameter int Q = 8380417,        
    parameter int GAMMA2 = (Q-1)/32, 
    parameter int WIDTH = 32,        
    parameter int M = (Q-1) / (2 * GAMMA2) 
)(
    input  logic h,                           // Hint signal
    input  logic signed [WIDTH-1:0] r,        // Input r
    output logic signed [$clog2(M)-1:0] r1    // Adjusted r1
);

    logic signed [WIDTH-1:0] r0_temp;         // Intermediate r0
    logic signed [WIDTH-1:0] r1_temp;         // Intermediate r1

    // Instance of Decompose module
    Decompose #(
        .Q(Q),
        .GAMMA(GAMMA2),
        .width(WIDTH),
        .r1_width(WIDTH),
        .r0_width(WIDTH)
    ) decompose_inst (
        .r(r),
        .r1(r1_temp),
        .r0(r0_temp)
    );

    always_comb begin
        // Adjust r1 based on hint h
        if (h && r0_temp > 0) begin
            r1 = (r1_temp + 1) % M;
        end else if (h && r0_temp <= 0) begin
            r1 = (r1_temp - 1) % M;
        end else begin
            r1 = r1_temp % M;
        end
    end

endmodule
