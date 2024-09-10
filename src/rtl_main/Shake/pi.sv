
/* verilator lint_off BLKSEQ */
module pi (
    input logic clk,
    input logic rst,
    input  logic [63:0] A[4:0][4:0],      
    output logic [63:0] A_prime[4:0][4:0] 
);  
    
    always_ff @(posedge clk or negedge rst) begin
           for (int i = 0; i < 5; i++) begin
                for (int j = 0; j < 5; j++) begin
                    for (int k = 0; k<64; k++) begin
                    int new_x = (i + 3 * j) % 5;
                    int new_y = i;
                    A_prime[new_x][new_y][k] = A[i][j][k];
                    end
                end
            end
    end
endmodule
