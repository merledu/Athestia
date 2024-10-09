module tb_keccak;

  // Testbench signals
  logic clk;
  logic rst;
  logic [1599:0] AB;
  logic [1599:0] X;
  logic round_done;

  // Instantiate the Keccak module
  keccak uut (
    .clk(clk),
    .rst(rst),
    .AB(AB),
    .X(X),
    .round_done(round_done)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Initial block to apply stimulus
  initial begin
    // Initialize signals
    clk = 0;
    rst = 1;  // Start with reset
    AB  = 1600'b0;  // Initialize AB with 0
    #10;

    // Provide the input D3 00 00 00 00 ... in right-to-left order
    AB = { 
      64'h0000000000000000, // [4,4]
      64'h0000000000000000, // [3,4]
      64'h0000000000000000, // [2,4]
      64'h0000000000000000, // [1,4]
      64'h0000000000000000, // [0,4]
      
      64'h0000000000000000, // [4,3]
      64'h0000000000000000, // [3,3]
      64'h0000000000000000, // [2,3]
      64'h8000000000000000, // [1,3]
      64'h0000000000000000, // [0,3]

      64'h0000000000000000, // [4,2]
      64'h0000000000000000, // [3,2]
      64'h0000000000000000, // [2,2]
      64'h0000000000000000, // [1,2]
      64'h0000000000000000, // [0,2]

      64'h0000000000000000, // [4,1]
      64'h0000000000000000, // [3,1]
      64'h0000000000000000, // [2,1]
      64'h0000000000000000, // [1,1]
      64'h0000000000000000, // [0,1]

      64'h0000000000000000, // [4,0]
      64'h0000000000000000, // [3,0]
      64'h0000000000000000, // [2,0]
      64'h0000000000000000, // [1,0]
      64'h00000000000000D3  // [0,0]
    };
    
    // Remove reset after a few cycles
    #10 rst = 0;

    // Wait for Keccak module to process
    #150;

    // Display the results
    $display("Output X: %h", X);
    
    // End the simulation
    #100 $stop;
  end

endmodule
