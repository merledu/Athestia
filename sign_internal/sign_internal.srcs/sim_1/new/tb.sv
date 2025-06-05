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
        zeta = 256'h9cecad5340ccc87c73ce5cb53614c19885545b3f6ff37cbd08589760b95be3d2;  // Dynamically set value
        #1000;
        $finish;
    end
endmodule
