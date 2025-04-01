module check_tb;
    parameter int k = 8;
    parameter int omega = 75;

    logic clk;
    logic rst;
    logic [663:0] y;
    logic [255:0] h [7:0];
    logic valid;

    check dut (
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
        #10 rst = 0;

        // Apply test vector
        y = 'h3228241e16130f0900000000000000000000000000000000000000000000000000b3534f4e3d392f221700aea18455f2eecbb3a06af4d38a755a5643029f8e1aee90502fd3ac625d190efff4e2898382645802;
        
        // Wait for processing
        #1000;

        
        $stop;
    end
endmodule
