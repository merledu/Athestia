`timescale 1ns / 1ps

function automatic signed [31:0] compute_remainder5(input signed [63:0] x, input signed [23:0] N);
    begin
        compute_remainder5 = x - ((x / N) * N);
        if (compute_remainder5 < 0)
            compute_remainder5 = compute_remainder5 + N;
    end
endfunction
import Dilithium_pkg::*;

module compute_infinity_norm #(
    parameter int k = Dilithium_pkg::l,
    parameter int q = Dilithium_pkg::q
)(
    input logic signed [31:0] vector [0:k-1][0:255],
    input logic clk,
    input logic rst,
    output logic done,
    output logic [31:0] max_value
);

    logic [7:0] i_count;
    logic [7:0] j_count;
    logic processing;

    // Intermediate value storage
    logic signed [31:0] adjusted_coeff;
    logic signed [31:0] abs_coeff;

    // Function: modpm(m, alpha)
//    function signed [31:0] modpm(input signed [31:0] m, input signed [31:0] alpha);
//        automatic signed [31:0] t;
//        t = ((alpha >>> 1) - m) % alpha;
//        if (t < 0)
//            t = t + alpha;
//        modpm = -t + (alpha >>> 1);
//    endfunction
function automatic signed [31:0] modpm(input signed [31:0] m, input signed [31:0] alpha);
            logic signed [31:0] half_alpha;
            begin
                half_alpha = alpha >>> 1; // alpha // 2
                modpm = -(compute_remainder5((half_alpha - m) , alpha)) + half_alpha;
            end
        endfunction
    
        // Function: abs(x)
        function automatic signed [31:0] abs(input signed [31:0] x);
            begin
                abs = (x < 0) ? -x : x;
            end
        endfunction
    

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            i_count <= 0;
            j_count <= 0;
            max_value <= 0;
            done <= 0;
            processing <= 1;
        end else if (processing) begin
            adjusted_coeff = modpm(vector[i_count][j_count], q);
            abs_coeff = abs(adjusted_coeff);

            if (abs_coeff > max_value)
                max_value <= abs_coeff;

            // Nested iteration logic
            if (j_count == 8'd255) begin
                j_count <= 0;
                if (i_count == (k - 1)) begin
                    i_count <= 0;
                    processing <= 0;
                    done <= 1;
                end else begin
                    i_count <= i_count + 1;
                end
            end else begin
                j_count <= j_count + 1;
            end
        end
    end

endmodule
