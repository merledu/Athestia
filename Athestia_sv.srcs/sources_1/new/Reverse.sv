//module Reverse #(
//    parameter int WIDTH = 128  // Default bit width (can be changed for different inputs)
//)(
//    input logic [WIDTH-1:0] in_data,  // Input data (bitstream)
//    output logic [WIDTH-1:0] out_data // Output reversed data (bitstream)
//);

//    // Process to reverse the byte order and also the bits within each byte
//    always_comb begin
//        out_data = '0;  // Initialize the output to zero

//        // Reverse the bytes and then reverse the bits within each byte
//        for (int i = 0; i < WIDTH/8; i = i + 1) begin
//            // Reverse the byte order without using dynamic part-selects
//            out_data[(i+1)*8-1 -: 8] = in_data[(WIDTH - 8 - i*8) +: 8];  // Reverse byte by byte
//        end
//    end

//    // Function to reverse a byte (this is used to reverse bits within a byte if needed)
//    function [7:0] reverse_byte(input [7:0] byte);
//        reverse_byte = {byte[0], byte[1], byte[2], byte[3], byte[4], byte[5], byte[6], byte[7]};
//    endfunction

//endmodule
