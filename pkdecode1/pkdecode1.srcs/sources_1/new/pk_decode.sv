`timescale 1ns / 1ps

module pk_decode #(
    parameter int q = 8380417,       // Modulus
    parameter int d = 13,           // Security parameter
    parameter int k = 8            // Number of vectors
) (
    input  logic clk,
    input  logic rst,
    input  logic start,
    output logic done,
    input  logic [total_pk_bits-1:0] pk, // Input public key
    output logic [255:0] rho,            // Output rho
    output logic [k-1:0][255:0][coeff_bits-1:0] t1 // Output polynomials
);

  // Derived Parameters
  localparam int bitlen_q = $clog2(q);
  localparam int bitlen_b = 1023;//bitlen_q - d;
  localparam int coeff_bits = bitlen_q - d;
  localparam int rho_bits = 256;
  localparam int zi_bits = 2560;//256 * coeff_bits;  // 256 coefficients per z_i
  localparam int total_pk_bits = rho_bits + k * zi_bits;

  // FSM States
  typedef enum logic [1:0] { IDLE, UNPACK, DONE } state_t;
  state_t state;

  logic [$clog2(k)-1:0] count= 0;  // Counter for polynomials
  logic [zi_bits-1:0] current_zi=0;

  // Assign rho from public key
  assign rho = pk[total_pk_bits-1 : rho_bits];


  simpleBitUnpack #(
    .b(bitlen_b)
  ) unpacker (
    .clk(clk),
    .v(current_zi),
    .w(t1[0])
  );

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      count <= 0;
      done  <= 0;
    end else begin
      case (state)
        IDLE: begin
          done <= 0;
          if (start) begin
            count <= 0;
            state <= UNPACK;
          end
        end

        UNPACK: begin
          // Extract the current z_i segment from pk
          current_zi <= pk[total_pk_bits - rho_bits - 1 * zi_bits : zi_bits];
          if (count == k - 1) begin
            state <= DONE;
          end else begin
            count <= count + 1;
          end
        end

        DONE: begin
          done <= 1;
          state <= IDLE;
        end
      endcase
    end
  end
endmodule