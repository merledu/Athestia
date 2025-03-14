`timescale 1ns / 1ps

module tb_Sample_in_ball;

  // Parameters
  parameter lmbda = 256;
  parameter t     = 60;
  
  // Signals to drive the DUT
  logic clk;
  logic rst;
  logic done;
  // Assuming a 64-bit input (even though the module declaration is [lmbda/4:0])
  // You may adjust the range in the DUT if needed.
  logic [63:0] in;
  // The module output is defined as an array of 256 2-bit vectors.
  logic [0:1] out [255:0];
  
  // Instantiate the Device Under Test (DUT)
  Sample_in_ball #(
    .lmbda(lmbda),
    .t(t)
  ) dut (
    .clk(clk),
    .rst(rst),
    .done(done),
    .in(in),
    .out(out)
  );
  
  // Clock generation: 10 ns period (5 ns high, 5 ns low)
  initial begin
    clk = 0;
    forever #2 clk = ~clk;
  end
  
  // Test stimulus
  initial begin
    // Initialize signals
    rst   = 1;    // Assert reset
    done  = 0;
    in    = 64'd0;  // Clear input initially
    
    // Wait 20 ns, then deassert reset
    #20;
    
    rst = 0;
    
    // Provide the test input: hex "1234567890abcdef"
    // This is a 64-bit value.
    in = 64'h72696d6172696d61;
    
    // Optionally, trigger any start or done signals if required by your design.
    // For example, if a 'start' signal was required you could drive it here.
    
    // Run simulation long enough to observe the output.
    #1000;
       for (int i = 0; i < 256; i++) begin
             $display("out[%0d] = %0d", i, out[i]);
         end
    
    // Finish the simulation.
    $finish;
  end

endmodule
