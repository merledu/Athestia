`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2024 12:58:22
// Design Name: 
// Module Name: Top_Power2round
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


////`include "Power2round.v"
////`include "Dilithium_pkg.sv"



module Top_Power2round #(
    parameter int T_WIDTH = 23,  
    parameter int T1_WIDTH = 10,
    parameter int T0_WIDTH = 13
)(
    input logic clk,
    input logic rst,
    input logic btn,
    output logic led
);

    // Input and Output for Power2round
    logic unsigned [T_WIDTH-1:0] t = 7011276;
    logic unsigned [T1_WIDTH-1:0] t1;
    logic signed [T0_WIDTH-1:0] t0;

    // Instantiate Power2round with parameters
    Power2round #(
        .T_WIDTH(T_WIDTH),
        .T1_WIDTH(T1_WIDTH),
        .T0_WIDTH(T0_WIDTH)
    ) u_power2round (
        .t(t),
        .t1(t1),
        .t0(t0)
    );
    
    always @(posedge clk) begin
        if (rst) begin
            led <= 1'b0;
        end else if (btn) begin
            // Check if t0 is within expected signed range
            if (t1 == 856 && t0 == -1076) begin
                led <= 1'b1;  // Correct output, set LED
            end else begin
                led <= 1'b0;  // Incorrect output, reset LED
            end
        end
    end


endmodule


















//module Top_Power2round (
//    input logic clk,
//    input logic rst,
//    input logic btn,
//    output logic led
//);
//    // Parameters from Dilithium_pkg
//    localparam integer d = Dilithium_pkg::d;
//    // Input and Output for Power2round
//    logic unsigned [22:0] a = 7011276;
//    logic unsigned [9:0] t1;
//    logic signed [12:0] t0;

//    // Instantiate Power2round
//    Power2round u_power2round (
//        .t(a),
//        .t1(t1),
//        .t0(t0)
//    );

//    // LED output to indicate correct output
//    always @(posedge clk) begin
//        if (rst) begin
//            led <= 1'b0;
//        end else if (btn) begin
//            // Check the outputs against expected values
//            if (t1 == 856 && t0 == -1076) begin
//                led <= 1'b1;  // Set LED if outputs match expected values
//            end else begin
//                led <= 1'b0;  // Reset LED if not
//            end
//        end
//    end

//endmodule

