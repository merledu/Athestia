module keccak_p (
    input  logic clk,
    input  logic rst,
    input  logic start,
    input  logic [1599:0] S,        
    output logic [1599:0] S_prime,  
    output logic done               
);
    
    logic [63:0] A[4:0][4:0];
    logic [63:0] A_final[4:0][4:0];
    
    
    logic valid;
    logic [31:0] round_counter;
    logic start_round;
    
    
    state_array state_inst (
        .clk(clk),
        .reset(rst),
        .bitstring(S),
        .Abc(A)
    );
    
    
    Rnd rnd_inst (
        .clk(clk),
        .rst(rst),
        .start(start_round),
        .valid(valid),
        .round(round_counter),
        .A(A),
        .A_final(A_final)
    );
    
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            round_counter <= 12 + 2 * $clog2(1600 / 25) - 24; //nr=24, 12+2l, l=6
            done <= 0;
            start_round <= 0;
        end else if (start) begin
            if (round_counter < (12 + 2 * $clog2(1600 / 25))) begin
                start_round <= 1;
                if (valid) begin
                    // Move to the next round
                    round_counter <= round_counter + 1;
                end
            end else begin
                // All rounds completed, output final state
                done <= 1;
                start_round <= 0;
            end
        end
    end
    
    // Convert the final state array back to bitstring
    always_comb begin
        int index = 0;
        for (int i = 0; i < 5; i++) begin
            for (int j = 0; j < 5; j++) begin
                S_prime[index+:64] = A_final[i][j];
                index += 64;
            end
        end
    end
endmodule
