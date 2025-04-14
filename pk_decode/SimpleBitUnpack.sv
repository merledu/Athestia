module simpleBitUnpack #(
  parameter int b = 10
) (
  input  logic clk,
  input  logic reset,
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
      // Correctly reverse byte order without bit reversal within bytes
      assign z[i*8 +: 8] = v[(total_bytes - 1 - i)*8 +: 8];
    end
  endgenerate

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      w <= '0;
    end else begin
      for (int i = 0; i < 256; i++) begin
        w[i] <= z[i*c +: 10];
      end
    end
  end

endmodule
