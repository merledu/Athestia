`timescale 1ns / 1ps

module DRBG_tb;
    logic clk;
    logic rst;
    logic [31:0] state_handle;
    logic [31:0] requested_number_of_bits;
    logic [31:0] max_number_of_bits_per_request;
    logic [31:0] requested_security_strength;
    logic [31:0] security_strength;
    logic [31:0] additional_input_length;
    logic [31:0] max_additional_input_length;
    logic prediction_resistance_request;
    logic prediction_resistance_flag;
    logic reseed_required_flag;
    logic [31:0] pseudorandom_bits;
    logic error_flag;
    logic success;

    // Instantiate the DRBG module
    DRBG uut (
        .clk(clk),
        .rst(rst),
        .state_handle(state_handle),
        .requested_number_of_bits(requested_number_of_bits),
        .max_number_of_bits_per_request(max_number_of_bits_per_request),
        .requested_security_strength(requested_security_strength),
        .security_strength(security_strength),
        .additional_input_length(additional_input_length),
        .max_additional_input_length(max_additional_input_length),
        .prediction_resistance_request(prediction_resistance_request),
        .prediction_resistance_flag(prediction_resistance_flag),
        .reseed_required_flag(reseed_required_flag),
        .pseudorandom_bits(pseudorandom_bits),
        .error_flag(error_flag),
        .success(success)
    );

    initial begin 
	clk=1;
	rst=1;
        state_handle = 32'h00000001;
        requested_number_of_bits = 32'd128;
        max_number_of_bits_per_request = 32'd256;
        requested_security_strength = 32'd112;
        security_strength = 32'd128;
        additional_input_length = 32'd0;
        max_additional_input_length = 32'd64;
        prediction_resistance_request = 0;
        prediction_resistance_flag = 1;
        reseed_required_flag = 0;

        // Reset pulse
        #10 rst = 0;

        // Apply test cases
        #20 requested_number_of_bits = 32'd512;  // Test exceeding max_number_of_bits_per_request
        #20 requested_number_of_bits = 32'd128;
            requested_security_strength = 32'd256;  // Test exceeding security strength
        #20 requested_security_strength = 32'd112;
            additional_input_length = 32'd128;  // Test exceeding max_additional_input_length
        #20 additional_input_length = 32'd0;
            prediction_resistance_request = 1;  // Test prediction resistance request
        #20 reseed_required_flag = 1;  // Test reseeding condition
        #20 rst = 1;  // Apply reset again
        #10 rst = 0;
        #50 ;
        $finish;
    end

 always begin
        #0.1 clk = ~clk;
    end
    
    initial begin
        $dumpfile("DRBG_tb.vcd");
        $dumpvars(0,DRBG_tb);
    end
           

endmodule
