module HintBitUnpack_tb;
    parameter int k = 8;
    parameter int omega = 75;

    logic clk;
    logic rst;
    logic [663:0] y;
    logic [255:0] h [k-1:0];
    logic valid;

    HintBitUnpack dut (
        .clk(clk),
        .rst(rst),
        .y(y),
        .h(h),
        .valid(valid)
    );

    // Clock generation
    always #2 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        y = 0;
        #5 rst = 0;

        // Apply test vector
        y = 'h3228241e16130f0900000000000000000000000000000000000000000000000000b3534f4e3d392f221700aea18455f2eecbb3a06af4d38a755a5643029f8e1aee90502fd3ac625d190efff4e2898382645802;
        
        // Wait for processing
        #1000;

        // Display results
        $display("Valid: %b", valid);
        for (int i = 0; i < k; i++) begin
            $display("h[%0d] = %b", i, h[i]);
        end
        
        $stop;
    end
endmodule
