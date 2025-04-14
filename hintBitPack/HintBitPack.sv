`timescale 1ns / 1ps

module HintBitPack #(
    parameter K = 8,
    parameter W = 75,
    parameter COEFF_WIDTH = 256
) (
    input  logic clk,
    input  logic rst,
    input  logic startpin,
    output logic endpin,
    input  logic  h [K-1:0][255:0],
    output logic [7:0] y [W + K - 1:0]
);

    typedef enum logic [1:0] {
        IDLE, PROCESS, DONE
    } state_t;

    state_t state;
    logic [7:0] index;
    logic [$clog2(K):0] i;
    logic [$clog2(256):0] j;

    // Separate process for synchronous reset
    always_ff @(posedge clk) begin
        if (rst) begin
//            for (int idx = 0; idx < (W + K); idx++) begin
//                y[idx] <= 1'b0;
//            end
            y <= '{default: 8'h00};
            index <= 0;
            i <= 0;
            j <= 0;
            endpin <= 1'b0;
            state  <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (startpin) begin
                        endpin <= 0;
                        index <= 0;
                        i <= 0;
                        j <= 0;
                        y <= '{default: 8'h00};
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    if (i < K) begin
                        if (j < 256'h100) begin
                            if (h[i][j]) begin
                                y[index] <= j[7:0];  // Assign value only in this condition
                                index <= index + 1'b1;
                            end 
                            j <= j + 1;
                        end else begin
                            y[W + i] <= index;
                            j <= 0;
                            i <= i + 1;
                        end
                    end else begin
                        state <= DONE;
                    end
                end
                DONE: begin
                    endpin <= 1;
                    if (!startpin) begin
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

endmodule
