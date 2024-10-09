module Theta (
  //input  logic clk,rst,
  input  logic [63:0] A[0:4][0:4],    
  output logic [63:0] A_prime[0:4][0:4]
  // output  logic [63:0] AB[4:0][4:0]
);

  logic [4:0][63:0] C;
  logic [4:0][63:0] D;

  // always_ff @( posedge clk && negedge rst ) begin
  always_comb begin
    C[0] = A[0][0]^A[0][1]^A[0][2]^A[0][3]^A[0][4];
    C[1] = A[1][0]^A[1][1]^A[1][2]^A[1][3]^A[1][4];
    C[2] = A[2][0]^A[2][1]^A[2][2]^A[2][3]^A[2][4];
    C[3] = A[3][0]^A[3][1]^A[3][2]^A[3][3]^A[3][4];
    C[4] = A[4][0]^A[4][1]^A[4][2]^A[4][3]^A[4][4];
  end

  always_comb begin 
    D[0] = C[4] ^ {C[1][62:0], C[1][63]};
    D[1] = C[0] ^ {C[2][62:0], C[2][63]};
    D[2] = C[1] ^ {C[3][62:0], C[3][63]};
    D[3] = C[2] ^ {C[4][62:0], C[4][63]};
    D[4] = C[3] ^ {C[0][62:0], C[0][63]};
  end

  always_comb begin
    //if (start) begin
    A_prime[0][0] = D[0] ^ A[0][0];
    A_prime[0][1] = D[0] ^ A[0][1];
    A_prime[0][2] = D[0] ^ A[0][2];
    A_prime[0][3] = D[0] ^ A[0][3];
    A_prime[0][4] = D[0] ^ A[0][4];
    A_prime[1][0] = D[1] ^ A[1][0];
    A_prime[1][1] = D[1] ^ A[1][1];
    A_prime[1][2] = D[1] ^ A[1][2];
    A_prime[1][3] = D[1] ^ A[1][3];
    A_prime[1][4] = D[1] ^ A[1][4];
    A_prime[2][0] = D[2] ^ A[2][0];
    A_prime[2][1] = D[2] ^ A[2][1];
    A_prime[2][2] = D[2] ^ A[2][2];
    A_prime[2][3] = D[2] ^ A[2][3];
    A_prime[2][4] = D[2] ^ A[2][4];
    A_prime[3][0] = D[3] ^ A[3][0];
    A_prime[3][1] = D[3] ^ A[3][1];
    A_prime[3][2] = D[3] ^ A[3][2];
    A_prime[3][3] = D[3] ^ A[3][3];
    A_prime[3][4] = D[3] ^ A[3][4];
    A_prime[4][0] = D[4] ^ A[4][0];
    A_prime[4][1] = D[4] ^ A[4][1];
    A_prime[4][2] = D[4] ^ A[4][2];
    A_prime[4][3] = D[4] ^ A[4][3];
    A_prime[4][4] = D[4] ^ A[4][4];
  end

  // logic [1599:0] AB;

  //     always_ff @( posedge clk or negedge rst ) begin

  //       AB[63:0]     = A_prime[0][0];
  //     AB[127:64]   = A_prime[0][1];
  //     AB[191:128]  = A_prime[0][2];
  //     AB[255:192]  = A_prime[0][3];
  //     AB[319:256]  = A_prime[0][4];

  //     AB[383:320]  = A_prime[1][0];
  //     AB[447:384]  = A_prime[1][1];
  //     AB[511:448]  = A_prime[1][2];
  //     AB[575:512]  = A_prime[1][3];
  //     AB[639:576]  = A_prime[1][4];

  //     AB[703:640]  = A_prime[2][0];
  //     AB[767:704]  = A_prime[2][1];
  //     AB[831:768]  = A_prime[2][2];
  //     AB[895:832]  = A_prime[2][3];
  //     AB[959:896]  = A_prime[2][4];

  //     AB[1023:960] = A_prime[3][0];
  //     AB[1087:1024] = A_prime[3][1];
  //     AB[1151:1088] = A_prime[3][2];
  //     AB[1215:1152] = A_prime[3][3];
  //     AB[1279:1216] = A_prime[3][4];

  //     AB[1343:1280] = A_prime[4][0];
  //     AB[1407:1344] = A_prime[4][1];
  //     AB[1471:1408] = A_prime[4][2];
  //     AB[1535:1472] = A_prime[4][3];
  //     AB[1599:1536] = A_prime[4][4];
  //     end
      
  

   // valid = 1;
    // end else begin
    // A_prime[0][0] = 0;
    // A_prime[0][1] = 0;
    // A_prime[0][2] = 0;
    // A_prime[0][3] = 0;
    // A_prime[0][4] = 0;
    // A_prime[1][0] = 0;
    // A_prime[1][1] = 0;
    // A_prime[1][2] = 0;
    // A_prime[1][3] = 0;
    // A_prime[1][4] =0;
    // A_prime[2][0] =0;
    // A_prime[2][1] = 0;
    // A_prime[2][2] = 0;
    // A_prime[2][3] = 0;
    // A_prime[2][4] = 0;
    // A_prime[3][0] = 0;
    // A_prime[3][1] =0;
    // A_prime[3][2] = 0;
    // A_prime[3][3] = 0;
    // A_prime[3][4] =0;
    // A_prime[4][0] = 0;
    // A_prime[4][1] =0;
    // A_prime[4][2] = 0;
    // A_prime[4][3] = 0;
    // A_prime[4][4] =0;
    // valid = 0;
    // end
  // end

endmodule
