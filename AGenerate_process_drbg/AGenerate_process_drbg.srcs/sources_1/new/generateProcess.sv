`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2025 22:39:03
// Design Name: 
// Module Name: generateProcess
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DRBG (
    input logic clk,
    input logic rst,
    input logic [31:0] state_handle,
    input logic [31:0] requested_number_of_bits,
    input logic [31:0] max_number_of_bits_per_request,
    input logic [31:0] requested_security_strength,
    input logic [31:0] security_strength,
    input logic [31:0] additional_input_length,
    input logic [31:0] max_additional_input_length,
    input logic prediction_resistance_request,
    input logic prediction_resistance_flag,
    input logic reseed_required_flag,
    output logic [31:0] pseudorandom_bits,
    output logic error_flag,
    output logic success
);
    
    typedef enum logic [1:0] {
        SUCCESS = 2'b00,
        ERROR_FLAG = 2'b01,
        CATASTROPHIC_ERROR_FLAG = 2'b10
    } status_t;
    
    status_t status;
    logic [31:0] new_working_state;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            pseudorandom_bits <= 0;
            error_flag <= 1'b1;
            success <= 1'b0;
            status <= ERROR_FLAG;
        end else begin
            error_flag <= 1'b0;
            if (state_handle == 0 || 
                requested_number_of_bits > max_number_of_bits_per_request || 
                requested_security_strength > security_strength || 
                additional_input_length > max_additional_input_length || 
                (prediction_resistance_request && !prediction_resistance_flag)) begin
                status <= ERROR_FLAG;
                success <= 1'b0;
                pseudorandom_bits <= 0;
                error_flag <= 1'b1;
            end else begin
                if (reseed_required_flag || prediction_resistance_request) begin
                    status = reseed_function(state_handle, prediction_resistance_request);
                    if (status != SUCCESS) begin
                        success <= 1'b0;
                        pseudorandom_bits <= 0;
                        error_flag <= 1'b1;
                    end else begin
                        new_working_state = state_handle + 1;
                        status = generate_algorithm(new_working_state, requested_number_of_bits);
                        if (status == SUCCESS) begin
                            pseudorandom_bits <= new_working_state;
                            success <= 1'b1;
                        end else begin
                            success <= 1'b0;
                            pseudorandom_bits <= 0;
                            error_flag <= 1'b1;
                        end
                    end
                end else begin
                    status = generate_algorithm(state_handle, requested_number_of_bits);
                    if (status == SUCCESS) begin
                        pseudorandom_bits <= state_handle + 1;
                        success <= 1'b1;
                    end else begin
                        success <= 1'b0;
                        pseudorandom_bits <= 0;
                        error_flag <= 1'b1;
                    end
                end
            end
        end
    end
    
    function automatic status_t reseed_function(input logic [31:0] handle, input logic pr_request);
        return SUCCESS;
    endfunction
    
    function automatic status_t generate_algorithm(input logic [31:0] working_state, input logic [31:0] req_bits);
        return SUCCESS;
    endfunction
    
endmodule
