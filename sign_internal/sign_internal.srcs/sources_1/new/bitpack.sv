`timescale 1ns / 1ps
import Dilithium_pkg::*;

function int flog4(int unsigned N);
    if (N == 0) return -1; 
    return $clog2(N) - ((N & (N - 1)) == 0 ? 0 : 1); 
endfunction

module bitpack #(   
    parameter int a = 2,
    parameter int b = 2,
    parameter b_len = flog4(a + b) + 1
)(    
     input logic start, 
    input  logic signed [b_len-1:0] w [255:0],
    
    output logic [(b_len * 256) - 1:0] outputt   
);
    always_comb begin
    if (start ==1 )begin
        outputt= 0;
        for (int i = 255; i >= 0; i--) begin
             outputt[i * b_len +: b_len] = b - w[255 - i];
//            count += b_len;
        end
        end
    end
endmodule