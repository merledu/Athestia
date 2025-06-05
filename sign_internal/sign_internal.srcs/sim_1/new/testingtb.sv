`timescale 1ns / 1ps

module BitExtender_tb;
    // Testbench signals
    logic [13:0] in_value;
    bit is_signed;
    logic [23:0] out_value;
    
    // Instantiate the DUT (Device Under Test)
    BitExtender uut (
        .in_value(in_value),
        .is_signed(is_signed),
        .out_value(out_value)
    );
    
    // Test procedure
    initial begin
        // Test case 1: Unsigned extension
        in_value = -1652; // 32767
        is_signed = 1;
        #10;
        $display("Unsigned: in_value=%h, out_value=%h", in_value, out_value);
        
       
        
        // Finish simulation
        $finish;
    end
endmodule
