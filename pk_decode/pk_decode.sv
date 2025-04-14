`timescale 1ns / 1ps

module pkDecode #(
    parameter int PK_SIZE = 256,  // Size of pk in bytes
    parameter int D = 13,        
    parameter int Q = 8380417,
    parameter k=8     
)(
    input  logic clk,                
    input  logic [8380416:0] pk,//8380416   //8*PK_SIZE-1
    output logic [255:0] rho,          // Extracted 32-byte rho
    output logic [k-1:0][255:0][9:0] t1 //define b where 9
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

    logic [7:0][POLY_SIZE-1:0] t1_data;

    always_ff @(posedge clk) begin
        // Extract rho (first 32 bytes)
        rho <= pk[8*32-1:0];
        t1_data[0] <= pk[2815:256];   //320 bytes
        t1_data[1] <= pk[5375 : 2816];  
        t1_data[2] <= pk[7935 : 5376];
        t1_data[3] <= pk[10495 : 7936];
        t1_data[4] <= pk[13055 : 10496];
        t1_data[5] <= pk[15615 : 13056];
        t1_data[6] <= pk[18175 : 15616];
        t1_data[7] <= pk[20735 : 18176];
    end

    simpleBitUnpack #(.b(B)) unpacker0 (
        .clk(clk),
        .v(t1_data[0]),
        .w(t1[0])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack1 (
        .clk(clk),
        .v(t1_data[1]),
        .w(t1[1])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack2 (
        .clk(clk),
        .v(t1_data[2]),
        .w(t1[2])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack3 (
        .clk(clk),
        .v(t1_data[3]),
        .w(t1[3])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack4 (
        .clk(clk),
        .v(t1_data[4]),
        .w(t1[4])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack5 (
        .clk(clk),
        .v(t1_data[5]),
        .w(t1[5])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack6 (
        .clk(clk),
        .v(t1_data[6]),
        .w(t1[6])
    );

    simpleBitUnpack #(.b(B)) simpleBitUnpack7 (
        .clk(clk),
        .v(t1_data[7]),
        .w(t1[7])
    );


endmodule
