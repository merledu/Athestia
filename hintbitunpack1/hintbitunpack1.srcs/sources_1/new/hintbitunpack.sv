import Dilithium_pkg::*;

module HintBitUnpack (
    input  logic clk,
    input  logic rst,
    input  logic [663:0] y,
    output logic [255:0] h [k-1:0],
    output logic valid
);
    logic [3:0] count_i;
    logic [9:0] index;

    
    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            count_i <= 0;
            index <= 0;
            for (int j = 0; j < k; j++) begin
                            h[j] <= 256'b0;  
                        end
        end
        else begin
            if (count_i < k) begin
                if(index+1 < y[(omega + count_i)*8 +: 8]) begin
                   index <= index + 1;
                end else begin
                    count_i <= count_i + 1;
                    index <= index + 1;
                end
                h[count_i][y[index*8+:8]] = 1;
            end
        end
    end
    
endmodule
