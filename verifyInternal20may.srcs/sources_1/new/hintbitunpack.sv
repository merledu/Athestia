module HintBitUnpack #(
    parameter int k = 8,
    parameter int omega = 75
)(
    input logic clk,
    input logic rst,
    input logic [0:((omega+k)*8)-1] y,
    output logic  h  [0:k-1][0:255],
    output logic valid,
    output logic done
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
    logic [7:0] y_byte [0:omega+k-1];

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            Index <= 0;
            First <= 0;
            outer_counter <= 0;
            inner_counter <= 0;
            final_counter <= 0;
            valid <= 0;
            h <= '{default: '0};
        end else begin
           y_byte[0]  <= y[0   : 7];
           y_byte[1]  <= y[8   : 15];
           y_byte[2]  <= y[16  : 23];
           y_byte[3]  <= y[24  : 31];
           y_byte[4]  <= y[32  : 39];
           y_byte[5]  <= y[40  : 47];
           y_byte[6]  <= y[48  : 55];
           y_byte[7]  <= y[56  : 63];
           y_byte[8]  <= y[64  : 71];
           y_byte[9]  <= y[72  : 79];
           y_byte[10] <= y[80  : 87];
           y_byte[11] <= y[88  : 95];
           y_byte[12] <= y[96  : 103];
           y_byte[13] <= y[104 : 111];
           y_byte[14] <= y[112 : 119];
           y_byte[15] <= y[120 : 127];
           y_byte[16] <= y[128 : 135];
           y_byte[17] <= y[136 : 143];
           y_byte[18] <= y[144 : 151];
           y_byte[19] <= y[152 : 159];
           y_byte[20] <= y[160 : 167];
           y_byte[21] <= y[168 : 175];
           y_byte[22] <= y[176 : 183];
           y_byte[23] <= y[184 : 191];
           y_byte[24] <= y[192 : 199];
           y_byte[25] <= y[200 : 207];
           y_byte[26] <= y[208 : 215];
           y_byte[27] <= y[216 : 223];
           y_byte[28] <= y[224 : 231];
           y_byte[29] <= y[232 : 239];
           y_byte[30] <= y[240 : 247];
           y_byte[31] <= y[248 : 255];
           y_byte[32] <= y[256 : 263];
           y_byte[33] <= y[264 : 271];
           y_byte[34] <= y[272 : 279];
           y_byte[35] <= y[280 : 287];
           y_byte[36] <= y[288 : 295];
           y_byte[37] <= y[296 : 303];
           y_byte[38] <= y[304 : 311];
           y_byte[39] <= y[312 : 319];
           y_byte[40] <= y[320 : 327];
           y_byte[41] <= y[328 : 335];
           y_byte[42] <= y[336 : 343];
           y_byte[43] <= y[344 : 351];
           y_byte[44] <= y[352 : 359];
           y_byte[45] <= y[360 : 367];
           y_byte[46] <= y[368 : 375];
           y_byte[47] <= y[376 : 383];
           y_byte[48] <= y[384 : 391];
           y_byte[49] <= y[392 : 399];
           y_byte[50] <= y[400 : 407];
           y_byte[51] <= y[408 : 415];
           y_byte[52] <= y[416 : 423];
           y_byte[53] <= y[424 : 431];
           y_byte[54] <= y[432 : 439];
           y_byte[55] <= y[440 : 447];
           y_byte[56] <= y[448 : 455];
           y_byte[57] <= y[456 : 463];
           y_byte[58] <= y[464 : 471];
           y_byte[59] <= y[472 : 479];
           y_byte[60] <= y[480 : 487];
           y_byte[61] <= y[488 : 495];
           y_byte[62] <= y[496 : 503];
           y_byte[63] <= y[504 : 511];
           y_byte[64] <= y[512 : 519];
           y_byte[65] <= y[520 : 527];
           y_byte[66] <= y[528 : 535];
           y_byte[67] <= y[536 : 543];
           y_byte[68] <= y[544 : 551];
           y_byte[69] <= y[552 : 559];
           y_byte[70] <= y[560 : 567];
           y_byte[71] <= y[568 : 575];
           y_byte[72] <= y[576 : 583];
           y_byte[73] <= y[584 : 591];
           y_byte[74] <= y[592 : 599];
           y_byte[75] <= y[600 : 607];
           y_byte[76] <= y[608 : 615];
           y_byte[77] <= y[616 : 623];
           y_byte[78] <= y[624 : 631];
           y_byte[79] <= y[632 : 639];
           y_byte[80] <= y[640 : 647];
           y_byte[81] <= y[648 : 655];
           y_byte[82] <= y[656 : 663];
        
        
        
            case (state)
                IDLE: begin
                    if (k > 0) begin
                        Index <= 0;
                        h <= '{default:'0};
                        outer_counter <= 0;
                        state <= COMPUTE_OUTER;
                    end
                end

                COMPUTE_OUTER: begin
                    if (outer_counter < k) begin
                    //outer loop start
                        if (y_byte[omega + outer_counter] < Index || y_byte[omega + outer_counter] > omega) begin
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
                        if (Index < y_byte[omega + outer_counter]) begin
                            if (Index > First) begin
                                if (y_byte[Index - 1] >= y_byte[Index]) begin
                                    state <= ERROR;
                                end
                            end
                            h[outer_counter][y_byte[Index]] <= 1;
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
                        if ((final_counter >= Index) && y_byte[final_counter] != 0) begin
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
                    done  <= 1;
//                    state <= IDLE;
                end

                ERROR: begin
                    valid <= 0;
                    done  <= 1;
//                    state <= IDLE;
                end

            endcase
        end
    end

endmodule


//clocks 75 +(8*75) = 675