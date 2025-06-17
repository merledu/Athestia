`timescale 1ns / 1ps

import Dilithium_pkg::*;

module pkDecode #(
    parameter int PK_SIZE = 256,  // Size of pk in bytes
    parameter int D = 13,        
    parameter int Q = 8380417,
    parameter k=8,
    parameter b=1023     
)(
    input  logic clk,rst,start,                
    input  logic [20735:0] pk,   //8*PK_SIZE-1
    output logic [255:0] rho,          // Extracted 32-byte rho
    output logic [31:0] t1 [k-1:0][0:255],//bitlen(b)-1
    output logic done
);
//y = bitlen(q - 1)
//    b = (2 ** (y - d)) - 1

    // Compute bit length of q - 1
    function automatic int bitlen(int q);
        return (q == 0) ? 1 : $clog2(q + 1);
    endfunction

    localparam int Y = bitlen(Q - 1);
    localparam int C = (1 << (Y - D)) - 1;
    localparam int Blen = bitlen(1023);
    localparam int B = 1023;
    localparam int POLY_SIZE = 32 * Blen * 8; // 32 coefficients, each of size C bits

    logic [0:POLY_SIZE-1] t1_data[0:7];
    logic [31:0] simple_bit_unpack_t1_out [0:k-1][0:255];//bitlen(b+1)-1

        always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            rho     <= 0;
            t1_data <= '{default: '0};
            done    <= 0;
            t1      <= '{default: '0};
            
        end else begin
            rho <= pk[0+:extract_bit_rho+1];
            t1_data[0] <= pk[2815:256];   
            t1_data[1] <= pk[5375:2816];  
            t1_data[2] <= pk[7935:5376];
            t1_data[3] <= pk[10495:7936];
            t1_data[4] <= pk[13055:10496];
            t1_data[5] <= pk[15615:13056];
            t1_data[6] <= pk[18175:15616];
            t1_data[7] <= pk[20735:18176];
             for (int i = 0; i < 8; i++) begin
                   t1[i] <=   simple_bit_unpack_t1_out[i];
               end
            done  <= 1;
        end
    end

    simpleBitUnpack #(.b(B)) simpleBitUnpack0 (
        .clk(clk),
        .v(t1_data[0]),
        .w(simple_bit_unpack_t1_out[0])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack1 (
        .clk(clk),        
        .v(t1_data[1]),
        .w(simple_bit_unpack_t1_out[1])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack2 (
        .clk(clk),
        .v(t1_data[2]),
        .w(simple_bit_unpack_t1_out[2])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack3 (
        .clk(clk),
        .v(t1_data[3]),
        .w(simple_bit_unpack_t1_out[3])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack4 (
        .clk(clk),
        .v(t1_data[4]),
        .w(simple_bit_unpack_t1_out[4])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack5 (
        .clk(clk),
        .v(t1_data[5]),
        .w(simple_bit_unpack_t1_out[5])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack6 (
        .clk(clk),
        .v(t1_data[6]),
        .w(simple_bit_unpack_t1_out[6])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack7 (
        .clk(clk),
        .v(t1_data[7]),
        .w(simple_bit_unpack_t1_out[7])
    );
   

endmodule