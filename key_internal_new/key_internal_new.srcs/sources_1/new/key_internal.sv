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
//    output logic [1023:0] shakeOut,
    output logic signed [63:0] t [0:k-1] [0:255]
);

    logic [255:0] swapOut;
    SwapNibbles #(256) swap (
        .in(zeta),
        .out(swapOut)
    );

    logic shakeDone, shakeRst, expandA_rst, expanda_done, s1_ntt_done, compute_t, shakeDone2, shakeStart;
    logic ntt_module_rst, t_ntt_done, nttinv_done, nttinv_rst, nttnew_done, pk_rst;
    logic [271:0] shakeIn;
    logic [511:0] shakeOut2;
    logic [1023:0] shakeOut;
    logic [20735:0] shakeIn2;
    logic [31:0] A [0:k-1] [0:l-1] [0:255];
    logic [3:0] count, ntt_count, nttinv_count, nttinv_count2;
    logic signed [($clog2(eta)+2):0] s1 [0:l-1] [0:255];
    logic signed [($clog2(eta)+2):0] s2 [0:k-1] [0:255];
    logic expands_done, rst_ntt, nttdone, ntt_disabler;
    logic signed [63:0] w [0:255], nttinv_w [0:255], checking [0:255];
    logic signed [31:0] w_hat [0:255], s1_ntt [0:l-1] [0:255];
    logic signed [63:0] nttinv_w_hat [0:255], t_ntt [0:k-1] [0:255];
    logic [2:0] i, j;
    logic [8:0] countA;
    logic [63:0] power2round_t;
    logic [9:0] power2round_t1;
    logic signed [12:0] power2round_t0;
    logic [63:0] power_t [0:k-1] [0:255];
    logic [9:0] power_t1 [0:k-1] [0:255];
    logic signed [12:0] power_t0 [0:k-1] [0:255];
    logic [255:0] pkencode_rho;
    logic [9:0] pkencode_t1 [0:k-1] [0:255];   
    logic [20735:0] pk;
    logic pk_done;

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
            if (shakeDone && expandA_rst === 'x) expandA_rst <= 1;
            if (expandA_rst) expandA_rst <= 0;
            if (expands_done && rst_ntt === 'x) begin
                rst_ntt <= 1;
                ntt_count <= 0;
                count <= 0;
            end 
            if (count >= 0) count <= count + 1;
            if (expands_done && count == 1) rst_ntt <= 0;
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
                    w[k] = extend_bits2(s1[ntt_count][k], 64, 1);
                end
            end
            if (expanda_done && s1_ntt_done && expands_done && t_ntt_done === 'x) begin
                t_ntt[i][countA-1] <= t_ntt[i][countA-1] + (A[i][j][countA-1] * s1_ntt[j][countA-1]);
                if (i == 7 && j == 6 && countA == 256) begin
                    i <= 'x;
                    j <= 'x;
                    countA <= 'x;
                    t_ntt_done <= 1;
                end
                if (countA < 256) countA <= countA + 1;
                else begin
                    countA <= 0;
                    if (j < l-1) j <= j + 1;
                    else begin
                        j <= 0;
                        if (i < k-1) i <= i + 1;
                        else i <= 0;
                    end
                end
            end
            nttinv_rst <= nttinv_done || t_ntt_done;
            nttinv_w_hat <= t_ntt[nttinv_count2];
            if (nttinv_done && ~nttinv_rst) begin
                t[nttinv_count2] <= nttinv_w;
                checking <= t_ntt[1];
                nttinv_count2 <= nttinv_count2 + 1;
            end
//            $display("hello",t_ntt[0]);
            if (t_ntt_done) begin
                nttinv_count2 <= 0;
                nttinv_w_hat <= t_ntt[0];
                nttinv_count <= nttinv_count + 1;
                if (nttinv_count == 1) begin
                    t_ntt_done <= 0;   
//                    $display("hello",t_ntt[0]);
                    //j <= 'x;
                    //countA <= 'x;             
                end
            end
//            t[j][countA] <= t[j][countA] + s2[j][countA];
            if (nttinv_count2 == 8) begin
                nttinv_rst <= 'x;
//                            t[j][countA] <= t[j][countA] + s2[j][countA];
                power2round_t <= t[j][countA] + s2[j][countA];
//                if (countA == 255) begin
//                power_t1[j][countA] <= power2round_t1;
//                power_t0[j][countA] <= power2round_t0;
//                end else begin
                power_t1[j][countA-1] <= power2round_t1;
                power_t0[j][countA-1] <= power2round_t0;
//                end
//            if (j === 'x && countA ==='x)begin
                //j <= 0;
                //countA<=0;
            if (!(j == 7 && countA == 256)) begin  // Stop when j = 7 and countA = 255
                        if (countA == 256) begin
                            countA <= 0;
                            if (j == 7) begin
                                j <= j; 
                                
                            end else
                                j <= j + 1;
                        end else begin
                            countA <= countA + 1;
                        end
                    end
             
            end
//            if (j == 7 && countA == 256 && nttinv_count == 2) begin
//                nttinv_count <= 0;
//            end
//pkencode_t1 <= power_t1;
    if (pk_rst && nttinv_count == 3) begin
        pkencode_rho <= shakeOut[255:0];
        pkencode_t1 <= power_t1;
    end
            
            if (pk_rst && nttinv_count == 4) begin
    pk_rst <= 0;
//    pkencode_rho <= shakeOut[255:0];
//    pkencode_t1 <= power_t1;
    nttinv_count <= nttinv_count;
end else if (j == 7 && countA == 256) begin
    if (pk_rst === 'x) begin  // First clock
        pk_rst <= 1;
        nttinv_count <= nttinv_count + 1;
    end 
    if (pk_rst == 1) begin // Second clock
        pk_rst <= 1;
        nttinv_count <= nttinv_count + 1;
    end
end

if (pk_done && shakeRst === 'x) begin
    shakeIn2 <= pk;
    shakeRst <= 1;
end
if (shakeRst) begin
    shakeRst <= 0;
end
if (pk_done && shakeRst == 0) begin
    shakeStart <= 1;
end
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

    ExpandS ExpandS (
        .clk(clk),
        .rst(expandA_rst),
        .start(shakeDone),
        .rho(shakeOut[767:256]),
        .s1(s1),
        .s2(s2),
        .done(expands_done)
    );

    NTT #(.WIDTH(64)) NTT (
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
    
    Power2round #(
            .T_WIDTH(64)
        ) uut (
            .t(power2round_t),
            .t1(power2round_t1),
            .t0(power2round_t0)
        );
        
    PkEncode PkEncode (
                .clk(clk),
                .reset(pk_rst),
                .rho(pkencode_rho),
                .t1(pkencode_t1),
                .pk(pk),
                .valid(pk_done)
            );       
    
    spongee #(
                    .msg_len(20740),
                    .d_len(512),
                    .capacity(512)
                ) shake256_compute_tr (
                    .clk(clk),
                    .reset(shakeRst),
                    .start(shakeStart),
                    .message({4'b1111, shakeIn2}),
                    .z(shakeOut2),
                    .done(shakeDone2)
                );
endmodule