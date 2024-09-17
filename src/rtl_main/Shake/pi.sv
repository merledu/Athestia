module pi (
    input  logic        clk,
    input  logic        rst,
    input  logic        start,          
    output logic        valid,          
    input  logic [63:0] A[4:0][4:0],    
    output logic [63:0] A_prime[4:0][4:0] 
);

    logic processing;  

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            
            valid <= 1'b0;
            processing <= 1'b0;

            for (int i = 0; i < 5; i++) begin
                for (int j = 0; j < 5; j++) begin
                    A_prime[i][j] <= 64'b0;
                end
            end
        end
        else if (start && !processing) begin
            processing <= 1'b1;
            valid <= 1'b0;  

            
            for (int i = 0; i < 5; i++) begin
                for (int j = 0; j < 5; j++) begin
                    for (int k = 0; k < 64; k++) begin
                        int new_x = (i + 3 * j) % 5;
                        int new_y = i;
                        A_prime[new_x][new_y][k] = A[i][j][k];
                    end
                end
            end

            valid <= 1'b1;
            processing <= 1'b0;  
        end
    end
endmodule