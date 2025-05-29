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
     input logic [0:(b_len * 256) - 1] v,
     output logic [0:w_len-1] w[255:0]
    );

    logic [$clog2((b_len * 256)):0] count;
      logic [0:(b_len * 256) - 1] z;

//    always_comb begin
//      $display("v = %h", v);
//    end

    always_comb begin
          for (int i = 0; i < 640; i++) begin
            z[8*(639 - i) +: 8] = v[8*i +: 8];  // reverse bit wise 
        end
        count = 0;
        for (int i = 0; i < 256; i++) begin
                   w[i] = b- z[count +: b_len];
                   count += b_len; 
            
        end
        
    end

endmodule