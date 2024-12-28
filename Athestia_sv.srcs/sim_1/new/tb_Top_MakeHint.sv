//`timescale 1ns / 1ps
//`timescale 1ns / 1ps

//module tb_Top_MakeHint;
//    logic clk = 0;
//    logic rst = 1;
//    logic btn = 0;
//    logic led;

//    Top_MakeHint UUT (
//        .clk(clk),
//        .rst(rst),
//        .btn(btn),
//        .led(led)
//    );

//    // Clock generation
//    always #5 clk = ~clk;  // 100 MHz clock

//    initial begin
//        // Initial reset
//        #10 rst = 0;

//        // Simulate button press
//        #100 btn = 1;
//        #10 btn = 0;

//        #100 $finish;
//    end
//endmodule
