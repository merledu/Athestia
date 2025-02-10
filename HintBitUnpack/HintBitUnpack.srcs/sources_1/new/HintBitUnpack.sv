module HintBitUnpack #(
    parameter int k = 8,
    parameter int omega = 75
)(
    input logic clk,
    input logic rst,
    input logic [7:0] y [k+omega-1:0],
    output logic [255:0] h [k-1:0],
    output logic valid
);


    typedef enum logic [2:0] {
        IDLE, COMPUTE_OUTER, COMPUTE_INNER, FINAL_CHECK, DONE, ERROR
    } state_t;

    state_t state;
    logic [8:0] Index;
    logic [8:0] First;
    logic [8:0] outer_counter;
    logic [8:0] inner_counter;
    logic [8:0] final_counter;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            Index <= 0;
            First <= 0;
            outer_counter <= 0;
            inner_counter <= 0;
            final_counter <= 0;
            valid <= 0;
            for (int i = 0; i < 8; i++) begin
                h[i] <= 0;
            end
        end else begin
            case (state)
                IDLE: begin
                    if (k > 0) begin
                        Index <= 0;
                        for (int i = 0; i < 8; i++) begin
                            h[i] <= 0;
                        end
                        outer_counter <= 0;
                        state <= COMPUTE_OUTER;
                    end
                end

                COMPUTE_OUTER: begin
                    if (outer_counter < k) begin
                    //outer loop start
                        if (y[omega + outer_counter] < Index || y[omega + outer_counter] > omega) begin
                            state <= ERROR;
                        end else begin
                            First <= Index;
                            inner_counter <= 0;
                            state <= COMPUTE_INNER;
                        end
                        //outer counter end
                    end else begin
                        final_counter <= 0;
                        state <= FINAL_CHECK;
                    end
                end

                COMPUTE_INNER: begin
                    if (inner_counter < omega) begin
                    //inner loop start
                        if (Index < y[omega + outer_counter]) begin
                            if (Index > First) begin
                                if (y[Index - 1] >= y[Index]) begin
                                    state <= ERROR;
                                end
                            end
                            h[outer_counter][y[Index]] <= 1;
                            Index <= Index + 1;
                            $display(Index);
                        end
                        inner_counter <= inner_counter + 1;
                      //inner loop end

                    end else begin
                        outer_counter <= outer_counter + 1;
                        state <= COMPUTE_OUTER;
                    end
                end

                FINAL_CHECK: begin
                // final loop to check, if list is valid?
                    if (final_counter < omega) begin
                        if ((final_counter >= Index) && y[final_counter] != 0) begin
                            state <= ERROR;
                        end else begin
                            final_counter <= final_counter + 1;
                        end
                    end else begin
                        state <= DONE;
                    end
                end

                DONE: begin
                    valid <= 1;
                    state <= IDLE;
                end

                ERROR: begin
                    valid <= 0;
                    state <= IDLE;
                end

            endcase
        end
    end

endmodule


//clocks 75 +(8*75) = 675