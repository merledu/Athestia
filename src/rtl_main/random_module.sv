/* verilator lint_off WIDTH */
module random_module (
    input logic clk,
    input logic rst_n,
    input logic enable,
    output logic signed [31:0] number
);

    logic signed [31:0] rand_num;
    logic [31:0] seed;

    initial begin
        integer fd;
        integer seed_file;
        fd = $fopen("/dev/urandom", "r");
        seed_file = $fgetc(fd);
        $fclose(fd);

        seed = seed_file ^ $time; // xor
        $urandom(seed);
        $display("Seed: %0d", seed);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rand_num <= 32'sd0;
        end else if (enable) begin
            rand_num <= $urandom;
        end
    end

    assign number = rand_num;

endmodule

