`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2025 02:46:33
// Design Name: 
// Module Name: sanityCheck
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module SanityCheck #(
    parameter int N = 1000,  // Matrix size (N x N)
    parameter real ALPHA = 0.000005
) (
    input  logic clk,
    input  logic rst,
    input  logic start,
    input  logic matrix [N-1:0][N-1:0], // 1-bit sample matrix
    output logic test_passed,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE, ROW_COUNT, COL_COUNT, CALCULATE_MAX, CHECK_PROBABILITY, DONE
    } state_t;

    state_t state, next_state;

    int row_max [N-1:0];
    int col_max [N-1:0];
    int X_R, X_C, X_max;
    int i, j;
    real p, probability;

    // Compute p = 2^(-1) since each sample is 1-bit
    initial begin
        p = 0.5;
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) 
            state <= IDLE;
        else 
            state <= next_state;
    end

    always_comb begin
        case (state)
            IDLE: next_state = (start) ? ROW_COUNT : IDLE;
            ROW_COUNT: next_state = (i < N-1) ? ROW_COUNT : COL_COUNT;
            COL_COUNT: next_state = (i < N-1) ? COL_COUNT : CALCULATE_MAX;
            CALCULATE_MAX: next_state = CHECK_PROBABILITY;
            CHECK_PROBABILITY: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            i <= 0;
            X_R <= 0;
            X_C <= 0;
            test_passed <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    i <= 0;
                    X_R <= 0;
                    X_C <= 0;
                    test_passed <= 1'b0;
                    done <= 1'b0;
                end

                ROW_COUNT: begin
                    int sample_count [2]; // Since each sample is 1-bit, only 0 or 1 counts
                    sample_count[0] = 0;
                    sample_count[1] = 0;
                    for (j = 0; j < N; j++) 
                        sample_count[matrix[i][j]]++;
                    row_max[i] = (sample_count[0] > sample_count[1]) ? sample_count[0] : sample_count[1];
                    if (row_max[i] > X_R) X_R = row_max[i];
                    if (i < N-1) i <= i + 1;
                    else i <= 0;
                end

                COL_COUNT: begin
                    int sample_count [2];
                    sample_count[0] = 0;
                    sample_count[1] = 0;
                    for (j = 0; j < N; j++) 
                        sample_count[matrix[j][i]]++;
                    col_max[i] = (sample_count[0] > sample_count[1]) ? sample_count[0] : sample_count[1];
                    if (col_max[i] > X_C) X_C = col_max[i];
                    if (i < N-1) i <= i + 1;
                end

                CALCULATE_MAX: begin
                    X_max = (X_R > X_C) ? X_R : X_C;
                end

                CHECK_PROBABILITY: begin
                    probability = 0.0;
                    for (j = X_max; j <= N; j++) begin
                        real bin_coeff = 1.0;
                        int k;
                        for (k = 0; k < j; k++) begin
                            bin_coeff = bin_coeff * (N - k) / (k + 1);
                        end
                        probability += bin_coeff * (p**j) * ((1 - p) ** (N - j));
                    end
                    test_passed <= (probability < ALPHA) ? 1'b0 : 1'b1;
                end

                DONE: begin
                    done <= 1'b1;
                end
            endcase
        end
    end
endmodule
