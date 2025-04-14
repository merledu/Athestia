`timescale 1ns/1ps

module topp_tb;

  // Clock and Reset signals
  logic clk;
  logic rst;
  logic led;

  // Instantiate the DUT (Device Under Test)
  topp dut (
    .clk(clk),
    .rst(rst),
    .led(led)
  );

  // Clock generation: 10ns period (100 MHz)
  initial clk = 0;
  always #0.005 clk = ~clk;

  // Stimulus
  initial begin
    // Initialize
    rst = 1;
    #15;
    rst = 0;

    // Wait and observe
    #1000;

    // End simulation
    $display("Simulation finished");
    $finish;
  end

  // Optional: Monitor output
  initial begin
    $monitor("Time=%0t | rst=%b | led=%b", $time, rst, led);
  end

endmodule
