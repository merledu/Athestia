import Dilithium_pkg::*;

function automatic signed [31:0] compute_remainder4(input signed [63:0] x, input signed [23:0] N);
    begin
        compute_remainder4 = x - ((x / N) * N);
        if (compute_remainder4 < 0)
            compute_remainder4 = compute_remainder4 + N;
    end
endfunction

module compute_r0 #(
    parameter int k = Dilithium_pkg::k,
    parameter int q = Dilithium_pkg::q
) (
    input logic signed [63:0] w   [0:k-1][0:255],
    input logic signed [63:0] cs2 [0:k-1][0:255],
    output logic signed [31:0] results [0:k-1][0:255],
    input logic clk,
    input logic rst,
    output logic done
);

    logic [7:0] i_count;
    logic [7:0] j_count;
    logic processing;
    logic [31:0] decompose_r0;
    logic [31:0] decompose_r;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            i_count    <= 0;
            j_count    <= 0;
            done       <= 0;
            processing <= 1;
        end else if (processing) begin
            // Compute (w[i][j] - cs2[i][j]) mod q
//            results[i_count][j_count] <= compute_remainder4(
//                w[i_count][j_count] - cs2[i_count][j_count], q
//            );

            // Handle nested counter logic
            if (j_count == 8'd255) begin
                j_count <= 0;
                if (i_count == (k - 1)) begin
                    i_count    <= 0;
                    processing <= 0;
                    done       <= 1;
                end else begin
                    i_count <= i_count + 1;
                end
            end else begin
                j_count <= j_count + 1;
            end
        end
    end
    
    always_comb begin
        decompose_r = compute_remainder4(
                    w[i_count][j_count] - cs2[i_count][j_count], q
                );
        results[i_count][j_count] = decompose_r0;              
    end
    
    Decompose #(
            .width(32)             
        ) LowBits (
            .r(decompose_r),
            .r0(decompose_r0)
        );

endmodule
