module Pi (
    // input  logic        clk,rst,       
    input  logic [63:0] A[0:4][0:4],    
    output logic [63:0] A_prime[0:4][0:4] 
);
    // always_ff @(posedge clk or posedge rst) begin
       always_comb begin
        A_prime[0][0] = A[0][0];
        A_prime[0][1] = A[3][0];
        A_prime[0][2] = A[1][0];
        A_prime[0][3] = A[4][0];
        A_prime[0][4] = A[2][0];

        A_prime[1][0] = A[1][1];
        A_prime[1][1] = A[4][1];
        A_prime[1][2] = A[2][1];
        A_prime[1][3] = A[0][1];
        A_prime[1][4] = A[3][1];

        A_prime[2][0] = A[2][2];
        A_prime[2][1] = A[0][2];
        A_prime[2][2] = A[3][2];
        A_prime[2][3] = A[1][2];
        A_prime[2][4] = A[4][2];

        A_prime[3][0] = A[3][3];
        A_prime[3][1] = A[1][3];
        A_prime[3][2] = A[4][3];
        A_prime[3][3] = A[2][3];
        A_prime[3][4] = A[0][3];

        A_prime[4][0] = A[4][4];
        A_prime[4][1] = A[2][4];
        A_prime[4][2] = A[0][4];
        A_prime[4][3] = A[3][4];
        A_prime[4][4] = A[1][4];
    end
endmodule
