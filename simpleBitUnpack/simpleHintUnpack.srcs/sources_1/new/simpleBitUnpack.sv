module simpleBitUnpack #(
  parameter int b = 1023  // Parameter defining bit width selection
) (
  input  logic clk ,
  input  logic reset ,
  input  logic [32 * b * $clog2(b + 1) - 1 : 0] v,  // Packed input byte string
  output logic [255:0][$clog2(b + 1)-1:0] w        // Output polynomial coefficients
);
  // Function to compute bitlen(b)
function automatic int bitlen(input int b_val);
  if (b_val == 0) 
    return 1;
  else 
    return $clog2(b_val + 1);
endfunction

  genvar i;
  generate
    for (i = 0; i < 256; i++) begin
      assign w[i] = v[i * bitlen(b) +: bitlen(b)]; 
    end
  endgenerate

endmodule
