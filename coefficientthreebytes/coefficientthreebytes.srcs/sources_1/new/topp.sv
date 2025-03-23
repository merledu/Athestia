`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2024 12:18:12 PM
// Design Name: 
// Module Name: topp
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


module top_three_bytes #(parameter int q = 8380417)(
    input logic btn,clk,rst,
    output logic led
);
    logic [7:0] b0;
    logic [7:0] b1;  
    logic [7:0] b2;  
    logic [23:0] check = 88676;
    logic [23:0] coef;
    logic valid;

    // Instantiate CoefFromThreeBytes
    CoefFromThreeBytes uut (
        .b0(b0),
        .b1(b1),
        .b2(b2),
        .q(q),
        .coef(coef), // Correct port name
        .valid(valid)
    );
     always_comb begin
           if (rst) begin
               led = 1'b0;
               b0 = 100;
               b1 = 90;
               b2 = 129;
           end else if (btn) begin
                if (coef == check && valid) begin
                           led = 1'b1;
                       end else begin
                           led = 1'b0;
                       end
                       end
                       end

//    always_comb begin
//        // Assign example values
//        b0 = 100;
//        b1 = 90;
//        b2 = 129;

//        if (btn) begin
//            if (coef == check && valid) begin
//                led = 1'b1;
//            end else begin
//                led = 1'b0;
//            end
//        end else begin
//            led = 1'b0;
//        end
//    end
endmodule
