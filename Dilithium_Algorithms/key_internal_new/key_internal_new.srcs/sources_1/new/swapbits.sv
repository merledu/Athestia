module SwapNibbles #(parameter WIDTH = 16) (
    input logic [WIDTH-1:0] in,
    output logic [WIDTH-1:0] out
);
    genvar i;
    generate
        for (i = 0; i < WIDTH; i += 8) begin : swap_block
            assign out[i+7:i] = {in[i+3:i], in[i+7:i+4]};
        end
    endgenerate
endmodule