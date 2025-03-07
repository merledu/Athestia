`timescale 1ns / 1ps

module simpleBitUnpack #(
  parameter int b = 1
) (
  input  logic [32 * bitlen(b) * 8 - 1 : 0] v,
  output logic [255:0][bitlen(b)-1:0] w
);

  function automatic int bitlen(input int b_val);
    return (b_val == 0) ? 1 : $clog2(b_val + 1);
  endfunction

  localparam int c = bitlen(b);
  localparam int total_bytes = 32 * c;
  localparam int total_bits = total_bytes * 8;

  logic [total_bits-1:0] z;

  generate
    for (genvar i = 0; i < total_bytes; i++) begin : byte_loop
      assign z[i*8 +: 8] = v[i*8 +: 8];  // Correct byte order without reversal
    end
  endgenerate

  // Compute coefficients as b - unpacked_value
  always_comb begin
    for (int i = 0; i < 256; i++) begin
      w[i] = b - z[i*c +: c];  // Subtract from b to match algorithm
    end
  end

endmodule