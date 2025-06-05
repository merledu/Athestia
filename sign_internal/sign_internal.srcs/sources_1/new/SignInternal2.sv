`timescale 1ns / 1ps
import Dilithium_pkg::*;

function automatic signed [31:0] modpm(input signed [31:0] m, input signed [31:0] alpha);
            logic signed [31:0] half_alpha;
            begin
                half_alpha = alpha >>> 1; // alpha // 2
                modpm = -(compute_remainder5((half_alpha - m) , alpha)) + half_alpha;
            end
        endfunction


function automatic logic [31:0] extend_bits(
    input logic [13:0] value,       // Input value (up to 14 bits)
    input bit is_signed            // 1 = signed extension, 0 = zero extension
    
);
    logic sign_bit;
    sign_bit = is_signed ? value[14 - 1] : 1'b0;
    return {{(32 - 14){sign_bit}}, value[14 - 1:0]};
endfunction



function automatic logic [31:0] extend_bits2(
    input logic [1:0] value,  // Handles both 4-bit and 14-bit inputs
    input bit is_signed
);
    logic [31:0] extended_value;
    extended_value[1:0]  = value;  // Assign directly (works for both cases)
    extended_value[31:2] = is_signed ? {30{value[1]}} : 30'b0; // Sign or zero extension
    return extended_value;
endfunction

function automatic logic [31:0] extend_bits3(
    input logic [3:0] value,  // Handles both 4-bit and 14-bit inputs
    input bit is_signed
);
    logic [31:0] extended_value;
    extended_value[3:0]  = value;  // Assign directly (works for both cases)
    extended_value[31:2] = is_signed ? {30{value[3]}} : 30'b0; // Sign or zero extension
    return extended_value;
endfunction

module sign_internal2
#(
    parameter msg_len = 3577,
    parameter ctx_len = 77,
    parameter rnd_len = 32
)
(
    input  logic [8*(32 + 32 + 64 + 32 * (((Dilithium_pkg::l + Dilithium_pkg::k) * ($clog2(2 * Dilithium_pkg::eta) + 1)) 
                                         + (Dilithium_pkg::d * Dilithium_pkg::k))) - 1 : 0] sk,
    input  logic [(msg_len*8)-1:0] n_msg,
    input  logic [(rnd_len*8)-1:0] rnd,
    input  logic [(ctx_len*8)-1:0] ctx,                                                                           
    input  logic clk,
    input  logic rst,
    output logic [37015:0] sign,
    output logic sign_done
);    
    logic skdone, initiator, nttdone, rst_ntt, ntt_disabler, s1_ntt_done, s2_ntt_done, shakeRst2, shakeDone2,w_ntt_inv_done,w1encode_done,shakeRst3,shakeDone3,Sampleinball_rst,poly_multiplier_done,mul_rst_s1,mul_done2,signers_rst,compute_r0_done,norm_done,norm_condition_check,compute_w_rst,highbits_done,w1_rst,prev_w1_done,hash_rst,ball_done,inntt_done,ins1_rst,ins2_done,incsigners_done,inccompute_done,new_ntt,int0_rst,hint_done;
    logic expandmask_rst, expandmask_done, nttinv_rst, inv_disabler, nttinv_done, t0_ntt_done, y_ntt_done, w_ntt_done, expanda_done,decompose_w_done,Sampleinball_done,v_c_hat_done,poly_done,cs1_done,mul_done,mul_rst_s2,signers_done,compute_r0_rst,norm_rst,if_done,if_rst,y_rst,y_done,compute_w_done,highbits_rst,w1_done,hash_done,ball_rst,inntt_rst,ins1_done,ins2_rst,incsigners_rst,inccompute_rst,final_condition,int0_done,hint_rst,sign_rst;
    logic signed [31:0] expandmask_output [0:l-1] [0:255];
    logic [(16+(ctx_len*8)+(msg_len*8))-1:0] msg;
    logic [31:0] expandmask_k;
    logic [3:0] counts1;
    logic [4:0] count_rst;
    logic signed [63:0] nttinv_w [0:255];
    logic signed [31:0] ntt_w [0:255];
    logic signed [63:0] nttinv_w_hat [0:255];
    logic signed [31:0] ntt_w_hat [0:255];
    logic signed [31:0] w [0:255];
    logic signed [31:0] w_hat [0:255];
    logic signed [3:0] s1 [0:Dilithium_pkg::l-1][0:255];
    logic signed [31:0] s1_ntt [0:Dilithium_pkg::l-1][0:255];
    logic signed [31:0] s2_ntt [0:Dilithium_pkg::k-1][0:255];
    logic signed [31:0] t0_ntt [0:Dilithium_pkg::k-1][0:255];
    logic signed [3:0] s2 [0:Dilithium_pkg::k-1][0:255];
    logic signed [13:0] t0 [0:Dilithium_pkg::k-1][0:255];
    logic [255:0] rho;
    logic [31:0] A [0:k-1][0:l-1][0:255];
    logic [511:0] tr;
    logic [255:0] K;
//    logic [(msg_len*8)+511:0] shakeIn;
    logic [(ctx_len*8)+(msg_len*8)+527:0] shakeIn;
    logic [767+(rnd_len*8):0] shakeIn2;
    logic [8703:0] shakeIn3;
    logic signed [63:0] w_ntt [0:k-1][0:255];
    logic signed [63:0] cs1 [0:k-1][0:255];
    logic signed [63:0] w_ntt_inv [0:k-1][0:255];
    logic signed [3:0] decompose_w [0:k-1][0:255];
    logic signed [31:0] y_ntt  [0:Dilithium_pkg::l-1][0:255];  
    logic signed [31:0] y_ntt_out  [0:Dilithium_pkg::l-1][0:255];
    logic signed[63:0] w_out  [0:Dilithium_pkg::k-1][0:255];
    logic signed [3:0] highbits_w  [0:Dilithium_pkg::k-1][0:255];
    logic [3:0] new_w  [0:Dilithium_pkg::k-1][0:255];
    logic [2:0] i, j;
    logic [8:0] countA;
    logic [63:0] decompose_r;
    logic [63:0] decompose_r1;
    logic [8191:0] w1_hat,encode_hat;
    logic [((lambda/4)*8)-1:0] shakeOut3,hash_out;    
    logic signed [1:0] Sampleinball_out [0:255];
    logic signed [1:0] ball_out [0:255];
    logic signed [31:0] v_c_hat [0:255];
    logic signed [63:0] v_c_hat_s1_ntt [0:Dilithium_pkg::l-1][0:255]; 
    logic signed [63:0] ins1_out [0:Dilithium_pkg::l-1][0:255];
    logic signed [63:0] v_c_hat_s2_ntt [0:Dilithium_pkg::k-1][0:255]; 
    logic signed [63:0] ins2_out [0:Dilithium_pkg::k-1][0:255];
    logic signed [63:0] int0_out [0:Dilithium_pkg::k-1][0:255];
    logic signed [31:0] singers_out [0:l-1][0:255];
//    logic signed [31:0] vector [0:l-1][0:255];
    logic signed [31:0] incsingers_out [0:l-1][0:255];
    logic signed [19:0] new_z [0:l-1][0:255];
    logic signed [31:0] vector2 [0:l-1][0:255];
    logic signed [31:0] compute_r0_out [0:k-1][0:255];
    logic signed [31:0] vector1 [0:k-1][0:255];
    logic signed [31:0] inccompute_r0_out [0:k-1][0:255];
    logic [31:0] norm_max;
    logic [31:0] loop_increment,kappa;
    logic [3:0] increment_ntt_count;
    logic signed h [0:Dilithium_pkg::k-1][0:255];
//    logic [8191:0] encode_hat;
    
//    logic signed [31:0] compute_r0_out [0:k-1][0:255];
    

    
    

    skDecode skDecode (
        .sk(sk),
        .rho(rho),
        .K(K),
        .tr(tr),
        .clk(clk),
        .rst(rst),
        .s1(s1),
        .s2(s2),
        .t0(t0),
        .done(skdone)
    );

    logic expandA_rst;

    NTT #(.width(32)) NTT (
        .clk(clk),
        .rst(rst_ntt),
        .w(w),
        .w_hat(w_hat),
        .done(nttdone),
        .disabler(ntt_disabler)
    );

    always_ff @(posedge clk) begin
        if (skdone && expandA_rst === 'x) begin
            expandA_rst <= 1;    
                
        end
        if (expandA_rst) begin
            expandA_rst <= 0;
            shakeIn <= {msg, tr};
        end
    end

    logic [255:0] swapOut;
//    SwapNibbles #(256) swap (
//        .in(rho),
//        .out(swapOut)
//    );

    ExpandA expandA (
        .clk(clk),
        .rst(expandA_rst),
        .start(skdone),
        .rho(rho),
        .A(A),
        .done(expanda_done)
    );

    logic [511:0] shakeOut, shakeOut2, expandmask_in;
    logic shakeDone, shakeStart;
    
    logic checking,checking2;

    always_ff @(posedge clk) begin
        rst_ntt <= initiator || nttdone;
        if (rst) begin
//        {8'd0, ctx_len[7:0], ctx_le, n_msg_le};
//            msg <= {n_msg,ctx,ctx_len,0};
                msg <= {n_msg,ctx,ctx_len[7:0],8'd0};            
            count_rst       <= 0;
            initiator       <= 0;
            counts1         <= 0;   
            s1_ntt_done     <= 0;
            s2_ntt_done     <= 0;  
            t0_ntt_done     <= 0;    
            expandmask_k    <= 0; 
            v_c_hat_done <= 0;
            for (int m = 0; m < k; m = m + 1) begin
                for (int n = 0; n < 256; n = n + 1) begin          
                    w_ntt[m][n] <= 32'd0;
                end
            end
            expandmask_in <= 0;
            kappa <= 0;
            loop_increment <= 0;
            y_ntt_done <= 0;
//            y_rst <= 0;
        end else begin
                                                                 
            if (skdone && counts1 < Dilithium_pkg::l) begin
                count_rst <= count_rst + 1;
                initiator <= 1;                   
                for (int i = 0; i < 256; i++) begin
                    w[i] <= extend_bits3(s1[counts1][i], 1);
                end
            end

            if (s1_ntt_done && counts1 < Dilithium_pkg::k) begin
                count_rst <= count_rst + 1;
                initiator <= 1;                   
                for (int i = 0; i < 256; i++) begin
                    w[i] <= extend_bits3(s2[counts1][i], 1);
                end
            end 

            if (s2_ntt_done && counts1 < Dilithium_pkg::k) begin
                count_rst <= count_rst + 1;
                initiator <= 1;                   
                for (int i = 0; i < 256; i++) begin
                        w[i] <= extend_bits(t0[counts1][i], 1);
                end
            end



//            if (rst_ntt) begin
//                rst_ntt <= 0;
//            end
            if (t0_ntt_done && counts1 < Dilithium_pkg::l && expandmask_done) begin
                count_rst <= count_rst + 1;
                initiator <= 1;          
                w <= expandmask_output[counts1];                             
            end  
            

                                    
            if (count_rst == 2) begin
                initiator <= 0;
                count_rst <= 'x;
            end else if (count_rst === 'x) begin
                initiator <= 0;   
            end

            if (nttdone && counts1 < Dilithium_pkg::l && ~rst_ntt && ~s1_ntt_done && ~s2_ntt_done) begin
                counts1           <= counts1 + 1;
                s1_ntt[counts1]   <= w_hat;                                
            end 

            if (nttdone && counts1 < Dilithium_pkg::k && ~rst_ntt && s1_ntt_done && ~s2_ntt_done) begin
                counts1           <= counts1 + 1;
                s2_ntt[counts1]   <= w_hat;                                
            end

            if (nttdone && counts1 < Dilithium_pkg::k && ~rst_ntt && s1_ntt_done && s2_ntt_done && ~t0_ntt_done) begin
                counts1           <= counts1 + 1;
                t0_ntt[counts1]   <= w_hat; 
            end    

            if (nttdone && counts1 < Dilithium_pkg::l && ~rst_ntt && t0_ntt_done && ~y_ntt_done) begin
                counts1           <= counts1 + 1;
                y_ntt[counts1]    <= w_hat; 
            end         

            if (counts1 == Dilithium_pkg::k && s1_ntt_done) begin
                s2_ntt_done       <= 1;
                counts1           <= 0; 
                count_rst         <= 0;
            end 

            if (counts1 == Dilithium_pkg::k && s2_ntt_done) begin
//              initiator        <= 'x; 
//              ntt_disabler     <= 1;
                t0_ntt_done       <= 1;
                counts1           <= 0; 
                count_rst         <= 0;
            end

            if (counts1 == Dilithium_pkg::l && t0_ntt_done && (~Sampleinball_done || Sampleinball_done === 'x)) begin
                initiator         <= 'x; 
                ntt_disabler      <= 1;
                y_ntt_done        <= 1;
            end

            if (counts1 == Dilithium_pkg::l && ~s1_ntt_done) begin
                s1_ntt_done       <= 1; 
                counts1           <= 0; 
                count_rst         <= 0;            
            end

            if (shakeDone && shakeRst2 === 'x) begin   
                shakeRst2         <= 1;                
            end
            if (shakeRst2) begin
                shakeRst2         <= 0;
                shakeIn2          <= {shakeOut, rnd, K}; 
            end

            if (shakeDone2 && expandmask_rst === 'x) begin
                expandmask_rst    <= 1;
                expandmask_k      <= kappa;
//                expandmask_in     <= 512'he80621459b826e15f0ecbc1d3f96ef97282edc413e22da4c53a582807940cb1f7d3601f9adb7f669fff9ec4db6008be271bf417076c98a53babf38cd5a552e0b;
            end
              

            if (expanda_done && y_ntt_done && w_ntt_done === 'x) begin
                w_ntt[i][countA-1] <= w_ntt[i][countA-1] + (A[i][j][countA-1] * y_ntt[j][countA-1]);
                if (i == 7 && j == 6 && countA == 256) begin
                    i <= 'x;
                    j <= 'x;
                    countA <= 'x;
                    w_ntt_done <= 1;
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
            
            if (w_ntt_done && i == 0 && j == 0 && countA == 0) begin
                i <= 'x;
                j <= 'x;
                countA <= 'x;           
             end                                                             
            
            nttinv_rst <= nttinv_rst || nttinv_done;
            if (w_ntt_done && nttinv_rst === 'x) begin
                nttinv_rst <= 1;
                nttinv_w_hat <= w_ntt[0];
                counts1 <= 0;
            end else if (nttinv_rst) begin
                nttinv_rst <= 0;            
            end
            
            if (nttinv_done && ~nttinv_rst) begin
                w_ntt_inv[counts1] <= nttinv_w;
            end
            
            if (w_ntt_done && counts1 == k && nttinv_done) begin
                w_ntt_inv_done <= 1;
                counts1 <= counts1;  
                nttinv_rst <= 1;
                inv_disabler <= 1;    
                i <= 0;
                countA <= 0;   
                counts1 <= 0;                                                    
            end else 
            if (w_ntt_done && counts1 < k && nttinv_done && nttinv_rst == 0) begin
                nttinv_w_hat <= w_ntt[counts1+1];
                counts1 <= counts1 + 1;            
            end
            if (w_ntt_inv_done) begin
                decompose_r <= w_ntt_inv[i][countA];
            
                if (countA > 0) begin
                    decompose_w[i][countA-1] <= decompose_r1;
                end
            end
                        
            if (w_ntt_inv_done) begin
                if (countA < 256) begin                
                    decompose_r <= w_ntt_inv[i][countA];
                end                                                                                                       
                decompose_w[i][countA-1] <= decompose_r1;                    
            end
            
            if (countA == 9'd256 && w_ntt_inv_done) begin                
                if (i == 3'd7) begin 
                    if (countA == 256) begin
                       countA <= 257;
                       decompose_w_done <= 1;
                    end           
                end else begin
                    i <= i + 1;
                    countA <= 0;
                end
            end else if (w_ntt_inv_done )begin
                countA <= countA + 1;
            end
            
            if (w1encode_done && shakeRst3 === 'x)begin
                shakeRst3 <= 1;
            end else if (shakeRst3) begin
                shakeRst3 <= 0;                
                shakeIn3 <= {w1_hat,shakeOut};
            end
            
            if (shakeDone3 && Sampleinball_rst === 'x) begin
                Sampleinball_rst <= 1;
            end else if (Sampleinball_rst) begin
                Sampleinball_rst <= 0;
            end
            
            if (Sampleinball_done && ntt_disabler && ~v_c_hat_done) begin
                ntt_disabler <= 0;
                rst_ntt <= 1;
                for (int p = 0; p < 256; p++ ) begin
                    w[p] <= extend_bits2(Sampleinball_out[p],1);
                end
            end else if (Sampleinball_done && ~ntt_disabler) begin
                rst_ntt <= 0;                
            end
            if (Sampleinball_done && nttdone) begin
                ntt_disabler <= 1; 
                v_c_hat <= w_hat;                   
                v_c_hat_done <= 1;
                counts1 <= 'x;                
                nttinv_rst <= 1; 
                inv_disabler <= 0;                 
                i <= 'x;
                j <= 'x;
                countA <= 'x;                           
            end
            
            
            
            if (v_c_hat_done && mul_rst_s1 === 'x) begin
                mul_rst_s1 <= 1;
            end else if (mul_rst_s1) begin
                mul_rst_s1 <= 0;
            end
            
            if (mul_done && mul_rst_s2 === 'x) begin
                mul_rst_s2 <= 1;
            end else if (mul_rst_s2) begin
                mul_rst_s2 <= 0;
            end
            
            if (mul_done && signers_rst === 'x) begin
                signers_rst <= 1;
            end else if (signers_rst) begin
                signers_rst <= 0;
            end
            
            if (mul_done2 && w_ntt_inv_done && compute_r0_rst === 'x) begin
                compute_r0_rst <= 1;
            end else if (compute_r0_rst) begin
                compute_r0_rst <= 0;
            end
            
            if (compute_r0_done && norm_rst === 'x) begin
                norm_rst <= 1;
            end else if (norm_rst && loop_increment == 0) begin
                norm_rst <= 0;
            end
            
//            highbits_w <= new_w;
            
            if (norm_condition_check && loop_increment == 0) begin
                norm_rst <= 1;
                expandmask_rst    <= 1;                
//                y_ntt_done <= 0;
//                counts1 <= 0;
//                ntt_disabler <= 0;
//                count_rst <= 0;
//                initiator <= 0;
                loop_increment <= loop_increment + 1;
                
            end
            
            
//            if (compute_w_rst)begin
//                compute_w_rst <= 0;
//            end
            
            if (kappa == 7) begin
                
                if (expandmask_done && y_rst === 'x) begin
                    y_rst <= 1;
                end else if (y_rst) begin
                    y_rst <= 0;
                end
                
                if (y_done && compute_w_rst === 'x) begin
                    compute_w_rst <= 1;
                end else if ( compute_w_rst) begin
                    compute_w_rst <=0;
                end    
                
                if (compute_w_done && highbits_rst === 'x) begin
                    highbits_rst <= 1;
                end else if (highbits_rst) begin
                    highbits_rst <= 0;
                end    
                
                if (highbits_done && w1_rst === 'x) begin
                    w1_rst <= 1;
                end else if (w1_rst) begin
                    w1_rst <= 0;
                end   
                
                if (w1_done && hash_rst === 'x) begin
                    hash_rst <= 1;                    
                end else if (hash_rst) begin
                    hash_rst <= 0;
                end             
                
                if (hash_done && ball_rst === 'x) begin
                    ball_rst <= 1;
                end else if (ball_rst) begin
                    ball_rst <= 0;
                end
                increment_ntt_count <= increment_ntt_count + 1;
                if (ball_done && inntt_rst === 'x) begin
                    inntt_rst <= 1;
                    increment_ntt_count <= 0;
                    for (int p = 0; p < 256; p++ ) begin
                         ntt_w[p] <= extend_bits2(ball_out[p],1);
                    end
                end else if (inntt_rst && increment_ntt_count == 2) begin
                    inntt_rst <= 0;
                end
                
                if (inntt_done && ins1_rst === 'x) begin
                    ins1_rst <= 1;
                end else if (ins1_rst) begin
                    ins1_rst <=0;
                end
                
                if (inntt_done && ins2_rst==='x) begin
                    ins2_rst <= 1;
                end else if (ins2_rst) begin
                    ins2_rst <= 0;
                end
                
                if (ins1_done && incsigners_rst==='x) begin
                    incsigners_rst <= 1;
                end else if (incsigners_rst) begin
                    incsigners_rst <= 0;
                end
                
                if (ins2_done && inccompute_rst==='x) begin
                    inccompute_rst <= 1;
                end else if (inccompute_rst) begin
                    inccompute_rst <= 0;
                end
                
                
                if(inccompute_done) begin
                    norm_rst <= 0;
                    expandmask_rst <= 'x;
                    y_rst <= 'x;
                    compute_w_rst <= 'x;
                end                                                
            end
            
            if (expandmask_done && y_rst) begin
                y_rst <=0;
            end
                        
            if ( y_done && compute_w_rst) begin
                    compute_w_rst <=0;
                end   
            if (compute_w_done && highbits_rst) begin
                highbits_rst <= 0;
            end   
            if (highbits_done && w1_rst) begin                                
                w1_rst <= 0;
            end  
            if (w1_done && hash_rst) begin                                
                hash_rst <= 0;
            end    
            if (hash_done && ball_rst) begin                                
                ball_rst <= 0;
            end
            if (ball_done && inntt_rst && new_ntt==='x) begin
                for (int p = 0; p < 256; p++ ) begin
                                     ntt_w[p] <= extend_bits2(ball_out[p],1);
                                end
                new_ntt <= 1;
            end else if (new_ntt && inntt_rst) begin
                inntt_rst <= 0;
            end
            
            if (inntt_done && ins1_rst) begin                                
                                ins1_rst <=0;
                            end
            if (inntt_done && ins2_rst) begin                                
                ins2_rst <=0;
            end
            
            if (ins1_done && incsigners_rst) begin

                                incsigners_rst <= 0;
                            end
                            
                            if (ins2_done && inccompute_rst) begin
                                inccompute_rst <= 0;
                            end
                            
                            if (inccompute_done) begin
                                norm_rst <= 0;                                
                            end
            if (norm_condition_check && if_done && kappa >= 7) begin
//                norm_rst <= 0;
                norm_rst <= 1;
                expandmask_rst <= 1; 
                y_rst <= 1;
                compute_w_rst <= 1;
                highbits_rst <= 1;
                w1_rst <= 1;
                hash_rst <= 1;
                ball_rst <= 1;
                inntt_rst <= 1;
                new_ntt <= 'x;
                ins2_rst <= 1;
                ins1_rst <= 1;
                incsigners_rst <= 1;
                inccompute_rst <= 1;
            end
            
            if (expandmask_rst && norm_condition_check) begin
                kappa <= kappa + l;
            end
            
            if (expandmask_rst) begin
                expandmask_rst    <= 0; 
                
            end
            
//            checking <= norm_condition_check && if_done && kappa >= 7;
//            checking2 <= nttdone && counts1 < Dilithium_pkg::l && ~rst_ntt && t0_ntt_done && ~y_ntt_done;
            if (loop_increment == 0) begin
                vector1 <= compute_r0_out ;
                                     vector2<=singers_out;
            end else if (loop_increment > 0) begin
                vector1 <= inccompute_r0_out ;
                vector2<=incsingers_out;
            end
            
            if (~norm_condition_check && if_done && int0_rst==='x)begin
                int0_rst <= 1;
            end else if (int0_rst) begin
                int0_rst <= 0;
            end
            
            if (int0_done && hint_rst==='x) begin
                hint_rst <= 1;
            end else if (hint_rst) begin
                hint_rst <= 0;
            end
                   
            if (hint_done && sign_rst === 'x) begin
                for (int m = 0; m < l; m = m + 1) begin
                            for (int n = 0; n < 256; n = n + 1) begin          
                                new_z[m][n] <= modpm(incsingers_out[m][n],q);
                            end
                        end
                sign_rst <= 1;                        
            end else if (sign_rst) begin
                sign_rst <=0;
            end
            
                                         
               
               
               
               
        end
    end
    
//    always_comb begin
//        rst_ntt = initiator || nttdone;
//    end
    sponge #(
             .msg_len((ctx_len*8)+(msg_len*8)+532),
             .d_len(512),
             .capacity(512)
   ) compute_mu_shake256 (
             .clk(clk),
             .reset(expandA_rst),
             .start(1'b1),
             .message({4'hF,shakeIn}),
             .z(shakeOut),
             .done(shakeDone)
   );
   
    sponge #(
             .msg_len(772+(rnd_len*8)),
             .d_len(512),
             .capacity(512)
    ) rho_double_prime (
             .clk(clk),
             .reset(shakeRst2),
             .start(1'b1),
             .message({4'hF,shakeIn2}),
             .z(shakeOut2),
             .done(shakeDone2)
    );
                     
    Expand_mask #(
             .gamma1(52487),
             .cols_l(l)
    ) Expand_mask (
             .clk(clk),
             .rst(expandmask_rst),
//             .rho_double_prime(expandmask_in),
             .rho_double_prime(shakeOut2),
             .k(kappa),
             .outputt(expandmask_output),
             .done(expandmask_done)
    );
      
    NTT_INV #(.WIDTH(64)) NTT_INV (
             .clk(clk),
             .rst(nttinv_rst),
             .w(nttinv_w),
             .w_hat(nttinv_w_hat),
             .disabler(inv_disabler),
             .done(nttinv_done)
    );      
                                                          
    Decompose #(
        .width(64),
        .r1_width(5)      
    ) HighBits (
        .r(decompose_r),
        .r1(decompose_r1)
    );
    
    w1encode #(
        .k(k), 
        .q(q), 
        .gamma(gamma2), 
        .widht(4)
    ) w1encode (
        .clk(clk),
        .reset(rst),
        .start(decompose_w_done),
        .w1(decompose_w),
        .done(w1encode_done),
        .w1_hat(w1_hat)
    );   
    
    sponge #(
        .msg_len(8708),
        .d_len((lambda/4)*8),
        .capacity(512)
    ) compute_commit_hash (
        .clk(clk),
        .reset(shakeRst3),
        .start(1'b1),
        .message({4'hF,shakeIn3}),
        .z(shakeOut3),
        .done(shakeDone3)
    );                     

    Sample_in_ball #(
        .lmbda(lambda),
        .t(60)
    ) Sampleinball (
        .clk(clk),
        .rst(Sampleinball_rst),        
        .done(Sampleinball_done),
        .in(shakeOut3),
        .out(Sampleinball_out)
    );

    multiply_vc_s1 multiply_vc_s1 (
        .clk(clk),
        .rst(mul_rst_s1),
        .v_c_hat(v_c_hat),
        .s1_ntt(s1_ntt),
        .v_c_hat_s1_ntt(v_c_hat_s1_ntt),
        .mul_done(mul_done)
    );
    multiply_vc_s2 multiply_vc_s2 (
     .clk(clk),
     .rst(mul_rst_s2),
     .v_c_hat(v_c_hat),
     .s2_ntt(s2_ntt),
     .v_c_hat_s2_ntt(v_c_hat_s2_ntt),
     .mul_done(mul_done2)
        );
        
    compute_signers_response_z compute_signers_response_z (
     .clk(clk),
     .rst(signers_rst),
     .y(expandmask_output),
     .cs1(v_c_hat_s1_ntt),
     .z(singers_out),
     .done(signers_done)
    );
    
    compute_r0 compute_r0 (
         .clk(clk),
         .rst(compute_r0_rst),
         .w(w_ntt_inv),
         .cs2(v_c_hat_s2_ntt),
         .results(compute_r0_out),
         .done(compute_r0_done)
        );
        
//    compute_infinity_norm #(.k(l)) compute_infinity_norm (
//             .clk(clk),
//             .rst(norm_rst),
//             .vector(compute_r0_out),
//             .max_value(norm_max),
//             .done(norm_done)
//            );
   
    norm_if norm_if (
                         .clk(clk),
                         .rst(norm_rst),
                         .vector(vector1),
                         .vector2(vector2),
                         .norm_condition_check(norm_condition_check),
                         .done(if_done)
                        );
                        
                        
    increment_y_ntt increment_y_ntt (
        .clk(clk),
        .rst(y_rst),
        .y_in(expandmask_output),
        .y_out(y_ntt_out),
        .done(y_done)
    );
    
    increment_compute_w increment_compute_w (
        .clk(clk),
        .rst(compute_w_rst),
        .Y(y_ntt_out),
        .A(A),
        .W(w_out),
        .final_done(compute_w_done)        
    );
    
    increment_highbits increment_highbits(
        .clk(clk),
        .rst(highbits_rst),
        .w_in(w_out),
        .w_out(highbits_w),
        .done(highbits_done)        
    );
    
    increment_w1 #(
            .k(k), 
            .q(q), 
            .gamma(gamma2), 
            .widht(4)
        ) increment_w1 (
            .clk(clk),
            .reset(w1_rst),
            .start(highbits_done),
            .w1(highbits_w),
            .done(w1_done),
            .w1_hat(encode_hat)
        );
    
    increment_has increment_has (
        .clk(clk),
        .rst(hash_rst),
        .encode_hat(encode_hat),
        .shakeOut(shakeOut),
        .shakeOut3(hash_out),
        .done(hash_done)                
    );
    
    Sample_in_ball #(
            .lmbda(lambda),
            .t(60)
        ) increment_hash (
            .clk(clk),
            .rst(ball_rst),        
            .done(ball_done),
            .in(hash_out),
            .out(ball_out)
        );
    
    NTT #(.width(32)) increment_NTT (
                .clk(clk),
                .rst(inntt_rst),
                .w(ntt_w),
                .w_hat(ntt_w_hat),
                .done(inntt_done)                
            );
    multiply_vc_s1 increment_multiply_vc_s1 (
                    .clk(clk),
                    .rst(ins1_rst),
                    .v_c_hat(ntt_w_hat),
                    .s1_ntt(s1_ntt),
                    .v_c_hat_s1_ntt(ins1_out),
                    .mul_done(ins1_done)
                );          
                
    multiply_vc_s2 increment_multiply_vc_s2 (
                     .clk(clk),
                     .rst(ins2_rst),
                     .v_c_hat(ntt_w_hat),
                     .s2_ntt(s2_ntt),
                     .v_c_hat_s2_ntt(ins2_out),
                     .mul_done(ins2_done)
                        );                

    compute_signers_response_z increment_compute_signers_response_z (
     .clk(clk),
     .rst(incsigners_rst),
     .y(expandmask_output),
     .cs1(ins1_out),
     .z(incsingers_out),
     .done(incsigners_done)
    );
    
    compute_r0 increment_compute_r0 (
             .clk(clk),
             .rst(inccompute_rst),
             .w(w_out),
             .cs2(ins2_out),
             .results(inccompute_r0_out),
             .done(inccompute_done)
            );
            
multiply_vc_t0 increment_multiply_vc_t0 (
                                 .clk(clk),
                                 .rst(int0_rst),
                                 .v_c_hat(ntt_w_hat),
                                 .s2_ntt(t0_ntt),
                                 .v_c_hat_s2_ntt(int0_out),
                                 .mul_done(int0_done)
                                    );                
compute_hints compute_hints (
    .clk(clk),
    .rst(hint_rst),
    .int0_out(int0_out),
    .w_out(w_out),
    .ins2_out(ins2_out),
    .done(hint_done),
    .h(h)    
);                

signencode signencode (
    .clk(clk),
    .rst(sign_rst),
    .c_h(hash_out),
    .z(new_z),
    .h(h),
    .hint_done(sign_done),
    .sigma(sign)    
);
endmodule

