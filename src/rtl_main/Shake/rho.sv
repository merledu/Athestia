module rho (
  input logic start,
  input logic rst,
  input logic clk,
  input  logic [63:0] A[4:0][4:0],  
  output logic [63:0] A_prime[4:0][4:0],  
  output logic valid

);


  logic [2:0] x;
  logic [2:0] y;
  logic [4:0] t;
  logic [63:0] offset;
  logic [2:0] x_reg, y_reg;
  logic [4:0] t_reg;
  logic [63:0] offset_reg;


  initial begin
    x_reg = 3'd1;
    y_reg = 3'd0;
    t_reg = 5'd0;
    A_prime[0][0] = A[0][0];
  end

  always_ff @(posedge clk or posedge rst) begin
    if (start && t_reg < 24) begin
      offset_reg <= ((t_reg + 1) * (t_reg + 2)) >> 1;
      for (int z = 0; z < 64; z++) begin
        A_prime[x_reg][y_reg][z] <= A[x_reg][y_reg][(z - offset_reg) % 64];
      end
      x_reg <= y_reg;
      y_reg <= (2 * x_reg + 3 * y_reg) % 5;
      if (t_reg == 23) begin
        valid <= 1'd1;
      end
      t_reg <= t_reg + 1;
    end
    
  end

endmodule
