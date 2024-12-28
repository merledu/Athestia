//////`include "Power2round.v"
//////`include "Dilithium_pkg.sv"

//module Top_Power2round (
//    input logic clk,
//    input logic rst,
//    input logic btn,
//    output logic led
//);
//    // Parameters from Dilithium_pkg
//    localparam integer d = Dilithium_pkg::d;
//    // Input and Output for Power2round
//    logic signed [22:0] a = 7011276;
//    logic signed [9:0] t1;
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
