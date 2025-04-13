`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2025 12:59:45
// Design Name: 
// Module Name: tb_Top_UseHint
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


module tb_Top_UseHint;
    // Parameters matching your top level
    parameter int r_width   = 32;
    parameter int r1v_width = 32;

    // Inputs
    reg clk;
    reg rst;
    reg btn;

    // Output
    wire led;

    // Instantiate the Unit Under Test (UUT)
    Top_UseHint #(
        .r_width(r_width),
        .r1v_width(r1v_width)
    ) uut (
        .clk(clk),
        .rst(rst),
        .btn(btn),
        .led(led)
    );

    // Clock generation: 10 ns period (5 ns half-cycle)
    initial begin
        clk = 0;
        forever #0.01 clk = ~clk;
    end

    // Test sequence: apply reset then simulate a button press.
    // The design?s constant arrays in top_usehint already provide the stimulus.
    initial begin
        // Initialize inputs
        rst = 1;
        btn = 0;

        // Apply Reset (active high)
        #10;
        rst = 0;

        // Wait a short time and simulate a button press to start the operation
        #10;
        btn = 1;  // Press button to trigger the operation in top_usehint
        #10;
        btn = 0;  // Release the button

        // Allow time for processing (UseHint module should assert "done", and the expected comparison is performed)
        #200;
        $finish; // End simulation
    end

endmodule
