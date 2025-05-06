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
    output logic [663:0] y // [W + K - 1:0]
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
                        if (j < 256) begin
                            if (h[i][j]) begin
case (index)
                                0:  y[7:0]       <= j[7:0];
                                1:  y[15:8]      <= j[7:0];
                                2:  y[23:16]     <= j[7:0];
                                3:  y[31:24]     <= j[7:0];
                                4:  y[39:32]     <= j[7:0];
                                5:  y[47:40]     <= j[7:0];
                                6:  y[55:48]     <= j[7:0];
                                7:  y[63:56]     <= j[7:0];
                                8:  y[71:64]     <= j[7:0];
                                9:  y[79:72]     <= j[7:0];
                                10: y[87:80]     <= j[7:0];
                                11: y[95:88]     <= j[7:0];
                                12: y[103:96]    <= j[7:0];
                                13: y[111:104]   <= j[7:0];
                                14: y[119:112]   <= j[7:0];
                                15: y[127:120]   <= j[7:0];
                                16: y[135:128]   <= j[7:0];
                                17: y[143:136]   <= j[7:0];
                                18: y[151:144]   <= j[7:0];
                                19: y[159:152]   <= j[7:0];
                                20: y[167:160]   <= j[7:0];
                                21: y[175:168]   <= j[7:0];
                                22: y[183:176]   <= j[7:0];
                                23: y[191:184]   <= j[7:0];
                                24: y[199:192]   <= j[7:0];
                                25: y[207:200]   <= j[7:0];
                                26: y[215:208]   <= j[7:0];
                                27: y[223:216]   <= j[7:0];
                                28: y[231:224]   <= j[7:0];
                                29: y[239:232]   <= j[7:0];
                                30: y[247:240]   <= j[7:0];
                                31: y[255:248]   <= j[7:0];
                                32: y[263:256]   <= j[7:0];
                                33: y[271:264]   <= j[7:0];
                                34: y[279:272]   <= j[7:0];
                                35: y[287:280]   <= j[7:0];
                                36: y[295:288]   <= j[7:0];
                                37: y[303:296]   <= j[7:0];
                                38: y[311:304]   <= j[7:0];
                                39: y[319:312]   <= j[7:0];
                                40: y[327:320]   <= j[7:0];
                                41: y[335:328]   <= j[7:0];
                                42: y[343:336]   <= j[7:0];
                                43: y[351:344]   <= j[7:0];
                                44: y[359:352]   <= j[7:0];
                                45: y[367:360]   <= j[7:0];
                                46: y[375:368]   <= j[7:0];
                                47: y[383:376]   <= j[7:0];
                                48: y[391:384]   <= j[7:0];
                                49: y[399:392]   <= j[7:0];
                                50: y[407:400]   <= j[7:0];
                                51: y[415:408]   <= j[7:0];
                                52: y[423:416]   <= j[7:0];
                                53: y[431:424]   <= j[7:0];
                                54: y[439:432]   <= j[7:0];
                                55: y[447:440]   <= j[7:0];
                                56: y[455:448]   <= j[7:0];
                                57: y[463:456]   <= j[7:0];
                                58: y[471:464]   <= j[7:0];
                                59: y[479:472]   <= j[7:0];
                                60: y[487:480]   <= j[7:0];
                                61: y[495:488]   <= j[7:0];
                                62: y[503:496]   <= j[7:0];
                                63: y[511:504]   <= j[7:0];
                                64: y[519:512]   <= j[7:0];
                                65: y[527:520]   <= j[7:0];
                                66: y[535:528]   <= j[7:0];
                                67: y[543:536]   <= j[7:0];
                                68: y[551:544]   <= j[7:0];
                                69: y[559:552]   <= j[7:0];
                                70: y[567:560]   <= j[7:0];
                                71: y[575:568]   <= j[7:0];
                                72: y[583:576]   <= j[7:0];
                                73: y[591:584]   <= j[7:0];
                                74: y[599:592]   <= j[7:0];
                            endcase

                                index <= index + 1;
                            end
                            j <= j + 1;
                        end else begin
                            case (i)
                                0: y[607:600] <= index;
                                1: y[615:608] <= index;
                                2: y[623:616] <= index;
                                3: y[631:624] <= index;
                                4: y[639:632] <= index;
                                5: y[647:640] <= index;
                                6: y[655:648] <= index;
                                7: y[663:656] <= index;
                            endcase
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
