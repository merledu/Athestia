module theta (
  input  logic clk,
  input  logic rst,
  input  logic [63:0] A[4:0][4:0],    
  output logic [63:0] A_prime[4:0][4:0]
);

  logic [63:0] C[4:0];          
  logic [63:0] D[4:0];          
  logic [63:0] A_int[4:0][4:0]; 
  int x, y, z;
  int a;

  always_ff @(posedge clk or posedge rst) begin
      for (x = 0; x < 5; x++) begin
        for (z = 0; z < 64; z++) begin
          C[x][z] = A[x][0][z] ^ A[x][1][z] ^ A[x][2][z] ^ A[x][3][z] ^ A[x][4][z];
        end
      end
      a <= 1 ^ 1;
  end

  always_comb begin
    D[0] = C[4] ^ {C[1][62:0],C[1][63]};
    D[1] = C[0] ^ {C[2][62:0],C[2][63]};
    D[2] = C[1] ^ {C[3][62:0],C[3][63]};
    D[3] = C[2] ^ {C[4][62:0],C[4][63]};
    D[4] = C[3] ^ {C[0][62:0],C[0][63]};
  end

  always_ff @(posedge clk or posedge rst) begin
      for (x = 0; x < 5; x++) begin
        for (y = 0; y < 5; y++) begin
          for (z = 0; z < 64; z++) begin
            A_prime[x][y][z] = A[x][y][z] ^ D[x][z];
          end
        end
      end

  end

endmodule
