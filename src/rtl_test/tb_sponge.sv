module tb_sponge;

// Parameters
parameter msg_len = 5;
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
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100 MHz clock (10ns period)
end

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
//    reset = 1; // Assert reset
//    message = 6'b0; // Initialize message to zero
//    start = 0;
    
    // Wait for 20 time units to ensure reset
     
    //#100;
    reset = 0; // Deassert reset
    start = 1;
    // Start the sponge operation
    
//    // Apply different messages as stimulus
    message = 5'b10011; // Test message 1
    #500
//    #100; // Wait for 100 time units

//    message = 6'b110011; // Test message 2
//    #100; // Wait for 100 time units
    
//    message = 6'b001001; // Test message 3
//    #100; // Wait for 100 time units
    
//    // Finish simulation after some time
//    #500;
    $stop;
end

// Monitor the output 'z'
initial begin
    $monitor("Time: %0t | Message: %b | Z (Output): %0h", $time, message, z);
end

endmodule
