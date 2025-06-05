`timescale 1ns/1ps

module KeyInternal_tb;
    parameter clock_period = 0.005;
    
    logic clk;
    logic rst;
    logic [255:0] zeta;
    
    key_internal uut (
        .clk(clk),
        .rst(rst),
        .zeta(zeta)
    );

    initial begin
        clk = 0;
        forever #(clock_period) clk = ~clk;
    end

    initial begin
        rst = 1;
        zeta = 256'h0;
        #clock_period;
        rst = 0;
        zeta = 256'h31bb2b3f619cc642f9338741270e37bbc8f94b8f8e6511d92561be60ec28b60e;  // Dynamically set value
        #1000;
        $finish;
    end
endmodule
