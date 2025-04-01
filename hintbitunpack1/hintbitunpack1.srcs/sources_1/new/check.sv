`timescale 1ns / 1ps

function int flog2(int unsigned N);
    if (N == 0) return -1; // log2(0) is undefined, handle separately
    return $clog2(N) - ( (N & (N - 1)) == 0 ? 0 : 1 ); // Subtract 1 if N is not a power of 2
  endfunction

module BitUnpack #(
    parameter int a = 524287,
    parameter int b = 524288,
    parameter int b_len = (flog2(a+b))+1,
    parameter int w_len = 32
    )(
     input logic [(b_len * 256) - 1:0] v,
     output logic [w_len-1:0] w[0:255]
    );
//    logic [(b_len * 256) - 1:0] out;
//    SwapNibbles #(b_len * 256) uut (
//            .in(v),
//            .out(out)
//        );
    logic [$clog2((b_len * 256)):0] count;

    always_comb begin
        count = 0;
        for (int i = 0; i < 256; i++) begin
            w[i] = b - v[count +: b_len];
            count += b_len; 
        end
        
    end

endmodule
