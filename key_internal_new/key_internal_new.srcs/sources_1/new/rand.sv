module random_module (
    input logic clk,
    input logic rst_n,
    input logic enable,
    output logic [255:0] number
);

    logic [255:0] rand_num;

    always_ff @(posedge clk or negedge rst_n) begin
        if (rst_n) begin
            rand_num <= 256'd0;
        end else if (enable) begin
            // Concatenate 8 random 32-bit values
            rand_num <= {
                $urandom, $urandom, $urandom, $urandom,
                $urandom, $urandom, $urandom, $urandom
            };
        end
    end

    assign number = rand_num;

endmodule
