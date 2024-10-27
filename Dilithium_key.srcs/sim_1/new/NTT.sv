`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2024 06:31:13 AM
// Design Name: 
// Module Name: NTT
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

module NTT#(parameter int q = 8380417)(
    input logic [31:0] w [255:0],  
    output logic [31:0] w_hat [255:0]
);
        
    logic [31:0] zetas [256];        

    logic [31:0] t, z;
    int m, j, length, start;

    initial begin
        zetas[0] = 0;
        zetas[1] = 4808194;
    end

  
    always_comb begin
        for (j = 0; j < 256; j++) begin
            w_hat[j] = w[j];
        end

        m = 0;
        length = 128;

        while (length >= 1) begin
            start = 0;

            while (start < 256) begin
                m = m + 1;
                z = zetas[m];

                for (j = start; j < start + length; j++) begin
                    t = (z * w_hat[j + length]) % q;

                    w_hat[j + length] = (w_hat[j] - t) % q;
                    w_hat[j] = (w_hat[j] + t) % q;
                end

                start = start + 2 * length;
            end

            length = length >> 1;
        end
    end
endmodule
