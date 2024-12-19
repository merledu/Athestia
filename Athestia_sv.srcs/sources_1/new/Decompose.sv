import Dilithium_pkg ::*;
module Decompose #(
    parameter int Q = q,        
    parameter int GAMMA = gamma2,
    parameter int width = 32,
    parameter int r1_width=32,
    parameter int r0_width=32
)(
    input logic [width-1:0] r,       
    output logic signed [r1_width-1:0] r1,     
    output logic signed [r0_width-1:0] r0      
);

    logic signed [width-1:0] r_prime;  
    logic signed [width-1:0] two_gamma;

    assign two_gamma = 2 * GAMMA;

    always_comb begin
        
        r_prime = r % Q;

        r0 = r_prime % two_gamma;

        if (r_prime - r0 == Q - 1) begin
            r0 = r0 - two_gamma;
            r1 = 0;
        end else begin
            r1 = (r_prime - r0) / two_gamma;
        end
    end

endmodule
