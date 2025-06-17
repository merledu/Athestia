`timescale 1ns / 1ps
import Dilithium_pkg::*;

module UseHint #(
    parameter int r_width    = 32,    // width of each r coefficient
    parameter int r1v_width  = 4    // width of each r1v output coefficient
)(
    input  logic                   clk,
    input  logic                   reset,
    input  logic   h [0:k-1][0:255],         // Hint matrix
    input  logic [r_width-1:0]     r [0:k-1][0:255], // Input polynomial matrix
    output logic [r1v_width-1:0]   r1v [0:k-1][0:255],// Output matrix
    output logic                   done          // High when full processing is complete
);

    // Local parameter for modulo operation
    localparam int m = (q - 1) / (2 * gamma2);

    // Counters for polynomial (i) and coefficient index (j)
    logic [$clog2(k)-1:0] i_counter=0;
    logic [$clog2(255):0] j_counter=0;

    // Wires for the outputs of the Decompose unit
    logic signed [r_width-1:0] r1;
    logic signed [r_width-1:0]   r0;

    // Single instance of the Decompose module
    Decompose #(
        .width(r_width),
        .r1_width(r_width),
        .r0_width(r_width)
    ) decompose_inst (
        .r(r[i_counter][j_counter]),
        .r1(r1),
        .r0(r0)
    );
    typedef enum logic [3:0] {
        IDLE,PROCESS,DONE} state_t;
        state_t current_state;

//always_ff @(posedge clk or posedge reset) begin
//case (current_state)
//            IDLE: begin
//                i_counter <= 0;
//                        j_counter <= 0;
//                        done      <= 0;
//            end
//            endcase
//   end



    // Sequential logic using counters instead of a full FSM
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
                i_counter <= 0;
                j_counter <= 0;
                done      <= 0;
                current_state <= IDLE;
            
        end else begin
        case (current_state)
                    IDLE: begin
                        i_counter <= 0;
                        j_counter <= 0;
                        done      <= 0;
                        current_state <= PROCESS;
                    end
                   PROCESS: begin
        
            // Process the current coefficient using the decompose outputs.
            // Check the hint and adjust r1 accordingly.
            if (h[i_counter][j_counter] == 1) begin
                if (r0 > 0)
                    r1v[i_counter][j_counter] <= (r1 + 1) % m;
                else
                    r1v[i_counter][j_counter] <= (r1 - 1) % m;
            end else begin
                r1v[i_counter][j_counter] <= r1;
            end

            // Update counters: Move through POLY_LEN coefficients per polynomial,
            // and then increment the polynomial index.
            if (j_counter == 256) begin
                j_counter <= 0;
                if (i_counter == k - 1) begin
                    i_counter <= 0;
//                    current_state <= PROCESS;  // Indicate complete processing for the entire matrix.
                    current_state <= DONE;
                end else begin
                    i_counter <= i_counter + 1;
                end
            end else begin
                j_counter <= j_counter + 1;
            end
        end
                    DONE: begin
       
            done <= 1;
            
            end
        
        endcase
    end
    end

endmodule