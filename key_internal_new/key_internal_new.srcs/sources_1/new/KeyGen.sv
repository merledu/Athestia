`timescale 1ns / 1ps

module KeyGen(
    input  logic clk, rst, 
    output logic final_done,
    output logic [39167:0] sk,
    output logic [20735:0] pk        
);
    
    logic [255:0] number;
    logic random_en,key_internal_rst;
    
    always_ff @(posedge clk or negedge rst) begin
        
        if (random_en === 'x && rst == 0) begin
                 random_en <= 1;                       
        end
        if(random_en) begin
            random_en <= 0;
        end
        key_internal_rst <= random_en;
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
            .zeta(number)
        );
    
endmodule
