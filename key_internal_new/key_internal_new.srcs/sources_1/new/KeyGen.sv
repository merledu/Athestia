`timescale 1ns / 1ps

module KeyGen(
    input  logic clk, rst, 
    output logic final_done,
    output logic [39167:0] sk,
    output logic [20735:0] pk        
);
    
    logic [255:0] number;
    logic random_en,key_internal_rst;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            random_en <= 0;
            key_internal_rst <= 0;
        end else begin
            if (random_en === 'x) begin
                random_en <= 1;
            end else begin
                random_en <= 0;
            end
            key_internal_rst <= random_en;
        end
    end

    random_module uut (
            .clk(clk),
            .rst_n(rst),
            .enable(random_en),
            .number(number)
        );
    key_internal uut1 (
            .clk(clk),
            .rst(key_internal_rst),
            .zeta('h24CAA1B44D22446B945452A70AF1D8B83F6ADBD0030F12D11C684681596D4CA5),
            .sk(sk),
            .pk(pk)
            
        );
    
endmodule
