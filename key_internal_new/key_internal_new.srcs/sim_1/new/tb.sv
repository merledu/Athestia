`timescale 1ns/1ps

            module KeyInternal_tb;
                parameter clock_period = 0.005;  // 100MHz clock
                
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
                    zeta = 256'h172cd8a1a5f4684ed7f31c02c90937834bd0e509605aac56a823e23ab32cbaf8;
                    #1000;  // Sufficient sim time
                    $finish;
                end
            endmodule
            