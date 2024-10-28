//module tb_pad10_1;

//    // Parameters
//    parameter x = 8;

//    // Testbench signals
//    logic [32:0] m;
//    logic [x-1:0] p;
//    logic clk;
//    logic rst;

//    // Instantiate the pad10_1 module
//    pad10_1 #(.x(x)) dut (
//        .m(m),
//        .p(p),
//        .clk(clk),
//        .rst(rst)
//    );

//    // Clock generation
//    initial begin
//        clk = 0;
//        forever #5 clk = ~clk; // 10 time units period
//    end

//    // Test sequence
//    initial begin
//        // Initialize signals
//        rst = 1;  // Start with reset
//        m = 0;    // Initial value for m

//        // Wait for a few clock cycles
//        #10;
        
//        // Release reset
//        rst = 0; // Reset
//        #10;     // Wait a bit
//        rst = 1; // Release reset

//        // Test Case 1: Provide values for m
//        m = 0; // Example value for m
//        #10; // Wait for clock cycle
////        $display("Test Case 1: m = %0d, p = %b", m, p);

////        // Test Case 2: Another value for m
////        m = 15; // Another example
////        #10; // Wait for clock cycle
////        $display("Test Case 2: m = %0d, p = %b", m, p);

////        // Test Case 3: Edge case for negative m
////        m = -3; // Example value for negative m
////        #10; // Wait for clock cycle
////        $display("Test Case 3: m = %0d, p = %b", m, p);

//        // Finish simulation
//        #10;
//        $finish;
//    end

//endmodule
