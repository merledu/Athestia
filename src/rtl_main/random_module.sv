module random_module (
    input logic clk,
    input logic rst_n,
    input logic enable,
    output logic signed [31:0] number
);

    logic signed [31:0] rand_num;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rand_num <= 32'sd0;
        end else if (enable) begin
            rand_num <= $urandom; // Generate random number
        end
    end

    assign number = rand_num;

endmodule
