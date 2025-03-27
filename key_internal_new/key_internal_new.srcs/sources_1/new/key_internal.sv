import Dilithium_pkg::*;
function automatic logic [63:0] extend_bits2(
            input logic [3:0] value,
            input int target_width,
            input bit is_signed
        );
            logic [63:0] extended_value;
            int i;
    
            extended_value[63:0] = value; 
    
            if (is_signed) begin
                for (i = 4; i < target_width; i++)  
                    extended_value[i] = value[3];   
            end else begin
                for (i = 4; i < target_width; i++) 
                    extended_value[i] = 1'b0;       
            end
            
            return extended_value;
        endfunction
module key_internal(
    input  logic clk, rst,
    input  logic [255:0] zeta,
    output logic [1023:0] shakeOut
);

    logic [255:0] swapOut;
    SwapNibbles #(256) swap (
        .in(zeta),
        .out(swapOut)
    );

    logic shakeDone, shakeStart, expandA_rst, expanda_done, s1_ntt_done, ntt_module_rst, t_ntt_done, nttinv_done, nttinv_rst;
    logic [271:0] shakeIn;
    logic [31:0] A [0:k-1] [0:l-1] [0:255];
    logic [3:0] count;
    logic [3:0] ntt_count,nttinv_count;
    logic signed [($clog2(eta)+2):0] s1 [0:l-1] [0:255];
    logic signed [($clog2(eta)+2):0] s2 [0:k-1] [0:255];
    logic expands_done;
    logic rst_ntt, nttdone, ntt_disabler;
    logic signed [63:0] w [0:255];
    logic signed [63:0] nttinv_w [0:255];
    logic signed [31:0] checking [0:255];
    logic signed [31:0] w_hat [0:255];
    logic signed [63:0] nttinv_w_hat [0:255];
    logic signed [31:0] s1_ntt [0:l-1] [0:255];
    logic signed [63:0] t_ntt [0:k-1] [0:255];
    logic signed [63:0] t [0:k-1] [0:255];
    logic [2:0] i;  
    logic [2:0] j;  
    logic [8:0] countA;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            shakeIn <= 272'd0; 
            i = 0;
            j = 0;
            countA = 0;
            nttinv_count <= 0;
            for (int m = 0; m < k; m = m + 1) begin
                        for (int n = 0; n < 256; n = n + 1) begin
                            t_ntt[m][n] <= 32'd0;
                        end
                    end
        end else begin
            ntt_module_rst <= rst_ntt || nttdone;
            shakeIn <= {l[7:0], k[7:0], swapOut}; 
            if (shakeDone && expandA_rst === 'x) begin
                expandA_rst <= 1;        
            end
            if (expandA_rst) begin
                expandA_rst <= 0;
            end
            if (expands_done && rst_ntt === 'x) begin
                rst_ntt <= 1;
                ntt_count <= 0;
                count <= 0;
            end 
            if (count >= 0) begin
                count <= count + 1; 
            end
            if (expands_done && count == 1) begin
                rst_ntt <= 0;
//                count <= 'x;
            end
            if (ntt_count < l && nttdone && ~ntt_module_rst) begin
                s1_ntt[ntt_count] <= w_hat;
                ntt_count <= ntt_count + 1;
            end
            if (ntt_count == l && s1_ntt_done === 'x) begin
                s1_ntt_done <= 1;
                ntt_disabler <= 1;
            end
            if (expands_done) begin
                for (int k = 0; k < 256; k++) begin
                    w[k] = extend_bits2(s1[ntt_count][k],64,1);
                end
            end
            if (expanda_done && s1_ntt_done && expands_done && t_ntt_done === 'x) begin
                t_ntt[i][countA-1] <= t_ntt[i][countA-1] + (A[i][j][countA-1] * s1_ntt[j][countA-1]);
                checking<=s1_ntt[j];
                if (i == 7 && j == 6 && countA == 256) begin
                                i <= 'x;
                                j <= 'x;
                                countA<='x;
                                t_ntt_done <= 1;
                                ntt_count <= 0;
//                                count <= 0;
                            end
                if (countA < 256) begin
                            countA <= countA + 1;
                        end else begin
                            countA <= 0;
                            if (j < l-1) begin
                                j <= j + 1;
                            end else begin
                                j <= 0;
                                if (i < k-1) begin
                                    i <= i + 1;
                                end else begin
                                    i <= 0;  
                                end
                            end
                        end
            end
            nttinv_rst <= nttinv_done || t_ntt_done;
            if (nttinv_done && ~nttinv_rst) begin
                 t[ntt_count] <= nttinv_w;
//                 nttinv_w_hat <= t_ntt[ntt_count];
                 ntt_count <= ntt_count + 1;

            end
            if (ntt_count && s1_ntt_done) begin
                j <= 0;
                countA <= 0;
            end 
            if (t_ntt_done) begin
                nttinv_w_hat <= t_ntt[0];
                nttinv_count <= nttinv_count + 1;
                if (nttinv_count == 2) begin
                t_ntt_done <= 0;                
                end
            end
         
        end
    end
    
    always_comb begin
        if (nttinv_done && ~nttinv_rst) begin
            nttinv_w_hat = t_ntt[ntt_count];
        end
    end


    sponge #(
        .msg_len(276),
        .d_len(1024),
        .capacity(512)
    ) shake256 (
        .clk(clk),
        .reset(rst),
        .start(1'b1),
        .message({4'b1111, shakeIn}),
        .z(shakeOut),
        .done(shakeDone)
    );

    ExpandA expandA (
        .clk(clk),
        .rst(expandA_rst),
        .start(shakeDone),
        .rho(shakeOut[255:0]),
        .A(A),
        .done(expanda_done)
    );

    ExpandS dut (
        .clk(clk),
        .rst(expandA_rst),
        .start(shakeDone),
        .rho(shakeOut[767:256]),
        .s1(s1),
        .s2(s2),
        .done(expands_done)
    );

    NTT #(.width(64)) NTT (
        .clk(clk),
        .rst(ntt_module_rst),
        .w(w),
        .w_hat(w_hat),
        .done(nttdone),
        .disabler(ntt_disabler)
    );
    
    NTT_INV #(.WIDTH(64)) NTT_INV (
            .clk(clk),
            .rst(nttinv_rst),
            .w(nttinv_w),
            .w_hat(nttinv_w_hat),
            .done(nttinv_done)
        );
    
endmodule