module poly_multiplier#(int m2_size=7) (
    input  logic signed [31:0] m1   [0:255],
    input  logic signed [31:0] m2  [0:m2_size-1][0:255],
    output logic signed [63:0] result  [0:m2_size-1][0:255]
);

    integer i, j;

    always_comb begin
        for (i = 0; i <= m2_size; i++) begin
            for (j = 0; j <= 255; j++) begin
                result[i][j] = m1[j] * m2[i][j];
            end
        end
    end

endmodule