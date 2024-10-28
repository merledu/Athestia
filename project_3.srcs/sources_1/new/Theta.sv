module Theta(
    input logic [63:0] A [0:4][0:4],
    output logic [63:0] A_prime [0:4][0:4]
    );

        logic [4:0][63:0] c_block;
        logic [4:0][63:0] d_block;
        
        always_comb begin
    
                    c_block[0] = A[0][0]^A[0][1]^A[0][2]^A[0][3]^A[0][4];
                    c_block[1] = A[1][0]^A[1][1]^A[1][2]^A[1][3]^A[1][4];
                    c_block[2] = A[2][0]^A[2][1]^A[2][2]^A[2][3]^A[2][4];
                    c_block[3] = A[3][0]^A[3][1]^A[3][2]^A[3][3]^A[3][4];
                    c_block[4] = A[4][0]^A[4][1]^A[4][2]^A[4][3]^A[4][4];
                    
                    d_block[0] = c_block[4] ^ {c_block[1][62:0], c_block[1][63]};
                    d_block[1] = c_block[0] ^ {c_block[2][62:0], c_block[2][63]};
                    d_block[2] = c_block[1] ^ {c_block[3][62:0], c_block[3][63]};
                    d_block[3] = c_block[2] ^ {c_block[4][62:0], c_block[4][63]};
                    d_block[4] = c_block[3] ^ {c_block[0][62:0], c_block[0][63]};
    
                    /*d_block[0] = c_block[4] ^ {c_block[1][0], c_block[1][63:1]};
                    d_block[1] = c_block[0] ^ {c_block[2][0], c_block[2][63:1]};
                    d_block[2] = c_block[1] ^ {c_block[3][0], c_block[3][63:1]};
                    d_block[3] = c_block[2] ^ {c_block[4][0], c_block[4][63:1]};
                    d_block[4] = c_block[3] ^ {c_block[0][0], c_block[0][63:1]};*/
    
                  //COLUMN_1
                   A_prime[0][0] = d_block[0] ^ A[0][0];
                   A_prime[0][1] = d_block[0] ^ A[0][1];
                   A_prime[0][2] = d_block[0] ^ A[0][2];
                   A_prime[0][3] = d_block[0] ^ A[0][3];
                   A_prime[0][4] = d_block[0] ^ A[0][4];
                  
                  //COLUMN_2
                   A_prime[1][0] = d_block[1] ^ A[1][0];
                   A_prime[1][1] = d_block[1] ^ A[1][1];
                   A_prime[1][2] = d_block[1] ^ A[1][2];
                   A_prime[1][3] = d_block[1] ^ A[1][3];
                   A_prime[1][4] = d_block[1] ^ A[1][4];
                 
                  //COLUMN_3
                   A_prime[2][0] = d_block[2] ^ A[2][0];
                   A_prime[2][1] = d_block[2] ^ A[2][1];
                   A_prime[2][2] = d_block[2] ^ A[2][2];
                   A_prime[2][3] = d_block[2] ^ A[2][3];
                   A_prime[2][4] = d_block[2] ^ A[2][4];
               
                  //COLUMN_4
                   A_prime[3][0] = d_block[3] ^ A[3][0];
                   A_prime[3][1] = d_block[3] ^ A[3][1];
                   A_prime[3][2] = d_block[3] ^ A[3][2];
                   A_prime[3][3] = d_block[3] ^ A[3][3];
                   A_prime[3][4] = d_block[3] ^ A[3][4];
                
                  //COLUMN_5
                   A_prime[4][0] = d_block[4] ^ A[4][0];
                   A_prime[4][1] = d_block[4] ^ A[4][1];
                   A_prime[4][2] = d_block[4] ^ A[4][2];
                   A_prime[4][3] = d_block[4] ^ A[4][3];
                   A_prime[4][4] = d_block[4] ^ A[4][4];
       
        end 
        
endmodule
