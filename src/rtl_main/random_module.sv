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
        // Use system call to get the current time (seconds since epoch)
        integer fd;
        integer seed_file;
        fd = $fopen("/dev/urandom", "r");
        seed_file = $fgetc(fd);
        $fclose(fd);

        seed = seed_file ^ $time; // Combine with simulation time
        $urandom(seed); // Set the seed for $urandom
        $display("Seed: %0d", seed); // Display the seed for debugging purposes
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rand_num <= 32'sd0;
        end else if (enable) begin
            rand_num <= $urandom; // Generate random number
        end
    end

    assign number = rand_num;

endmodule

