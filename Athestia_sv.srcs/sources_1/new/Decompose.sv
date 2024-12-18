module Decompose #(
    parameter int Q = 8380417,        
    parameter int GAMMA = (Q - 1) / 32 
)(
    input logic [31:0] r,       
    output logic signed [31:0] r1,     
    output logic signed [31:0] r0      
);

    logic signed [31:0] r_prime;  
    logic signed [31:0] two_gamma;

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
