module tb_random_module;

    // Testbench signals
    logic clk;
    logic rst_n;
    logic enable;
    logic signed [255:0] number;

    // Instantiate the DUT (Design Under Test)
    random_module uut (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .number(number)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        $display("Starting Testbench...");
        // Initialize inputs
        rst_n = 0;
        enable = 0;

        // Apply reset
        #10;
        rst_n = 1;

        // Enable random number generation
        #10;
        enable = 1;
        #12;
        enable = 0;

        // Let it run for a few cycles
        repeat (10) begin
            @(posedge clk);
            $display("Time: %0t | Random Number: %0d", $time, number);
        end

        // Disable and enable = 0;
        #20;
        $finish;
    end

endmodule
