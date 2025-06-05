module HintBitUnpack #(
    parameter int k = 8,
    parameter int omega = 75
)(
    input logic clk,
    input logic rst,
    input logic [((omega+k)*8)-1:0] y,
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
         y_byte[0]  <= y[7   : 0];
        y_byte[1]  <= y[15  : 8];
        y_byte[2]  <= y[23  : 16];
        y_byte[3]  <= y[31  : 24];
        y_byte[4]  <= y[39  : 32];
        y_byte[5]  <= y[47  : 40];
        y_byte[6]  <= y[55  : 48];
        y_byte[7]  <= y[63  : 56];
        y_byte[8]  <= y[71  : 64];
        y_byte[9]  <= y[79  : 72];
        y_byte[10] <= y[87  : 80];
        y_byte[11] <= y[95  : 88];
        y_byte[12] <= y[103 : 96];
        y_byte[13] <= y[111 : 104];
        y_byte[14] <= y[119 : 112];
        y_byte[15] <= y[127 : 120];
        y_byte[16] <= y[135 : 128];
        y_byte[17] <= y[143 : 136];
        y_byte[18] <= y[151 : 144];
        y_byte[19] <= y[159 : 152];
        y_byte[20] <= y[167 : 160];
        y_byte[21] <= y[175 : 168];
        y_byte[22] <= y[183 : 176];
        y_byte[23] <= y[191 : 184];
        y_byte[24] <= y[199 : 192];
        y_byte[25] <= y[207 : 200];
        y_byte[26] <= y[215 : 208];
        y_byte[27] <= y[223 : 216];
        y_byte[28] <= y[231 : 224];
        y_byte[29] <= y[239 : 232];
        y_byte[30] <= y[247 : 240];
        y_byte[31] <= y[255 : 248];
        y_byte[32] <= y[263 : 256];
        y_byte[33] <= y[271 : 264];
        y_byte[34] <= y[279 : 272];
        y_byte[35] <= y[287 : 280];
        y_byte[36] <= y[295 : 288];
        y_byte[37] <= y[303 : 296];
        y_byte[38] <= y[311 : 304];
        y_byte[39] <= y[319 : 312];
        y_byte[40] <= y[327 : 320];
        y_byte[41] <= y[335 : 328];
        y_byte[42] <= y[343 : 336];
        y_byte[43] <= y[351 : 344];
        y_byte[44] <= y[359 : 352];
        y_byte[45] <= y[367 : 360];
        y_byte[46] <= y[375 : 368];
        y_byte[47] <= y[383 : 376];
        y_byte[48] <= y[391 : 384];
        y_byte[49] <= y[399 : 392];
        y_byte[50] <= y[407 : 400];
        y_byte[51] <= y[415 : 408];
        y_byte[52] <= y[423 : 416];
        y_byte[53] <= y[431 : 424];
        y_byte[54] <= y[439 : 432];
        y_byte[55] <= y[447 : 440];
        y_byte[56] <= y[455 : 448];
        y_byte[57] <= y[463 : 456];
        y_byte[58] <= y[471 : 464];
        y_byte[59] <= y[479 : 472];
        y_byte[60] <= y[487 : 480];
        y_byte[61] <= y[495 : 488];
        y_byte[62] <= y[503 : 496];
        y_byte[63] <= y[511 : 504];
        y_byte[64] <= y[519 : 512];
        y_byte[65] <= y[527 : 520];
        y_byte[66] <= y[535 : 528];
        y_byte[67] <= y[543 : 536];
        y_byte[68] <= y[551 : 544];
        y_byte[69] <= y[559 : 552];
        y_byte[70] <= y[567 : 560];
        y_byte[71] <= y[575 : 568];
        y_byte[72] <= y[583 : 576];
        y_byte[73] <= y[591 : 584];
        y_byte[74] <= y[599 : 592];
        y_byte[75] <= y[607 : 600];
        y_byte[76] <= y[615 : 608];
        y_byte[77] <= y[623 : 616];
        y_byte[78] <= y[631 : 624];
        y_byte[79] <= y[639 : 632];
        y_byte[80] <= y[647 : 640];
        y_byte[81] <= y[655 : 648];
        y_byte[82] <= y[663 : 656];

        
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