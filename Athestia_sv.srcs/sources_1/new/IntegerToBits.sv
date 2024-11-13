`timescale 1ns / 1ps

module IntegerToBits #(
    parameter int ALPHA = 8 // Default bit-width, configurable
)(
    input  logic [ALPHA-1:0] x,       // Input integer x of width ALPHA
    output logic [ALPHA-1:0] y        // Output bit array y (little-endian)
);

    always_comb begin
        for (int i = 0; i < ALPHA; i++) begin
            y[i] = x[i];  // Extract each bit and place in corresponding index of y
        end
    end
endmodule






//module IntegerToBits #(
//    parameter int ALPHA = 64,          
//    parameter int BIT_WIDTH = 64       
//)(
//    input  logic [ALPHA-1:0] x,       
//    output logic [BIT_WIDTH-1:0] y    
//);

//    logic [ALPHA-1:0] x_prime;        // Temporary variable to hold the shifting input
//    integer i;

//    always_comb begin
//        x_prime = x;                 
//        // Loop to compute each bit of y in little-endian order
//        for (i = 0; i < ALPHA; i = i + 1) begin
//            y[i] = x_prime % 2;       // Extract the least significant bit of x_prime
//            x_prime = x_prime >> 1;   // Right shift x_prime to move to the next bit
////             y[i] = x[i]; 
//        end
//    end

//endmodule