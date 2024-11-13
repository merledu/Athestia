`timescale 1ns / 1ps

import Dilithium_pkg::*;

module Power2round (
    input  logic signed [22:0] t,        // 23-bit input t
    output logic signed [9:0]   t1,      // 10-bit output t1
    output logic signed [12:0]  t0       // 13-bit output t0
);

    logic signed [22:0] t_shifted;

    always_comb begin
        t_shifted = t + (1 << (d - 1)) - 1;
        t1 = t_shifted >>> d;

        t0 = t - (t1 <<< d);  
    end

endmodule