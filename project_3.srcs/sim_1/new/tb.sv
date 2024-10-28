module tb_sponge;

// Parameters
parameter msg_len = 9;
parameter d_len = 2048;
parameter capacity = 512;
parameter r = 1600 - capacity;

// Testbench Signals
logic clk;
logic reset;
logic [msg_len-1:0] message;
logic start;
logic [d_len-1:0] z;

// Clock generation
always #5 clk = ~clk;

// Instantiate the DUT (Device Under Test)
sponge #(.msg_len(msg_len), .d_len(d_len), .capacity(capacity), .r(r)) dut (
    .clk(clk),
    .reset(reset),
    .message(message),
    .start(start),
    .z(z)
);

// Test procedure
initial begin
    // Initialize signals
    clk = 0;
    reset = 1; // Assert reset
    message = 9'b0; // Initialize message to zero
    start = 0;
    #20;

    reset = 0; // Deassert reset
    
    clk=0;
    // Start the sponge operation with message = 111110011
    start = 1;
    message = 9'b111110011;
   
    #1000;

    $stop;
end

// Monitor the output 'z'
initial begin
    $monitor("Time: %0t | Message: %b | Z (Output): %0h", $time, message, z);
end

endmodule